-- Main Characters

SMODS.Joker{
	key = 'clover',
	loc_txt = {
		name = 'Clover',
		text = {
		'If {C:attention}played hand{} contains',
		'only {C:attention}1{} card, retrigger that',
		'card {C:attention}#1#{} additional times'
		}
	},
	atlas = 'Main',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 0, y = 0},
	config = {
		extra = {
			repetitions = 3
		}
	}, 
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.repetitions } }
    end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play and #context.full_hand == 1 then
			return {
				message = 'Again!',
				repetitions = card.ability.extra.repetitions,
				card = card,
			}
		end
	end
}

if KEVINSUTY.config_file.unjank_flowey then

	--Flowey's card sell hook

	local sell_card_stuff = Card.sell_card
	function Card:sell_card()
		if self.ability.set == "Joker" and self.config.center.key ~= "j_sncuty_flowey" and self.config.center.rarity == 1 and self.sell_cost > 0 then
			local contained = false
			for _, v in ipairs(G.GAME.jokers_sold) do
				if v == self.config.center.key then
					contained = true
					break
				end
			end
			if not contained then
				table.insert(G.GAME.jokers_sold, self.config.center.key)
				if #G.GAME.jokers_sold > 3 then
					table.remove(G.GAME.jokers_sold, 1)
				end
			end
		end
		sell_card_stuff(self)
	end

	SMODS.Sticker{
		key = 'flowey',
		loc = {
			name = 'Flowey Joker'
		},
		atlas = 'Main',
		pos = {x = 5, y = 0},
		default_compat = true,
		hide_badge = true,
		no_collection = true,
		sets = {
			Joker = true
		},
		calculate = function(self, card, context)
			if context.end_of_round and context.main_eval and not context.blueprint and not context.retrigger_joker then
				G.E_MANAGER:add_event(Event({
					delay = 0.15,
					trigger = "after",
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
			end
		end
	}

	SMODS.Joker{
		key = 'flowey',
		loc_txt = {
			name = 'Flowey',
			text = {
			'When {C:attention}Blind{} is selected,',
			'create {C:dark_edition}Negative{} copies of {C:attention}3',
			'last {C:attention}sold {C:common}common {C:attention}Jokers',
			'Destroy them at end of round'
			}
		},
		atlas = 'Main',
		rarity = 3,
		cost = 9,
		unlocked = true,
		discovered = true,
		blueprint_compat = false,
		eternal_compat = true,
		perishable_compat = true,
		pos = {x = 1, y = 0},
		config = {
			extra = {
				
			},
		},
		loc_vars = function(self,info_queue,card)
			if G.GAME.jokers_sold then
				if #G.GAME.jokers_sold > 2 then
					info_queue[#info_queue+1] = G.P_CENTERS[G.GAME.jokers_sold[#G.GAME.jokers_sold-2]]
				end
				if #G.GAME.jokers_sold > 1 then
					info_queue[#info_queue+1] = G.P_CENTERS[G.GAME.jokers_sold[#G.GAME.jokers_sold-1]]
				end
				if #G.GAME.jokers_sold > 0 then
					info_queue[#info_queue+1] = G.P_CENTERS[G.GAME.jokers_sold[#G.GAME.jokers_sold]]
				end
			end
			return {vars = {  } }
		end,
		
		calculate = function(self, card, context)
			if context.setting_blind and not context.blueprint then
				local generation = 0
				if #G.GAME.jokers_sold <= 3 then
					generation = #G.GAME.jokers_sold
				elseif #G.GAME.jokers_sold > 3 then
					generation = 3
				end

				local current = 0
				for i=1, generation do
					local _card = SMODS.add_card({set = "Joker", key = G.GAME.jokers_sold[#G.GAME.jokers_sold-current], edition = "e_negative"})
					_card.ability["sncuty_flowey"] = true
					_card.sell_cost = 0
					current = current + 1
				end

				if generation > 0 then
					return true
				end
			end
		end
	}

else

	--Flowey's card sell hook

	local sell_card_stuff = Card.sell_card
	function Card:sell_card()
		if self.ability.set == "Joker" and self.config.center.key ~= "j_sncuty_flowey" and self.config.center.rarity == 1 and self.config.center.blueprint_compat == true then
			if #G.flowey.cards >= 3 then
				local removal = G.flowey.cards[1]
				G.flowey:remove_card(removal)
				removal:remove()
			end
			SMODS.add_card({set = "Joker", area = G.flowey, key = self.config.center.key, no_edition = true})
		end
		sell_card_stuff(self)
	end
	
	SMODS.Joker{
		key = 'flowey',
		loc_txt = {
			name = 'Flowey',
			text = {
			'Copies the ability of',
			'{C:attention}3{} last {C:attention}sold {C:common}common {C:attention}Jokers{}',
			'{s:0.8,C:inactive}(Must be {s:0.8,C:chips}Blueprint{s:0.8,C:inactive} compatible)'
			}
		},
		atlas = 'Main',
		rarity = 3,
		cost = 9,
		unlocked = true,
		discovered = true,
		blueprint_compat = false,
		eternal_compat = true,
		perishable_compat = true,
		pos = {x = 1, y = 0},
		config = {
			extra = {
				
			},
		},
		loc_vars = function(self,info_queue,card)
			if G.flowey then
				if #G.flowey.cards > 2 then
					local card3 = G.flowey.cards[#G.flowey.cards-2]
					info_queue[#info_queue+1] = G.P_CENTERS[card3.config.center_key]
				end
				if #G.flowey.cards > 1 then
					local card2 = G.flowey.cards[#G.flowey.cards-1]
					info_queue[#info_queue+1] = G.P_CENTERS[card2.config.center_key]
				end
				if #G.flowey.cards > 0 then
					local card1 = G.flowey.cards[#G.flowey.cards]
					info_queue[#info_queue+1] = G.P_CENTERS[card1.config.center_key]
				end
				
			end
			if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
				info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
			end
			return {vars = {  } }
		end,
		
		calculate = function(self, card, context)
			local cards_to_process = { 
				G.flowey.cards[#G.flowey.cards-2],
				G.flowey.cards[#G.flowey.cards-1],
				G.flowey.cards[#G.flowey.cards]
			}
		
			for _, flowey_card in ipairs(cards_to_process) do
				local ret = SMODS.blueprint_effect(card, flowey_card, context)
				if ret then
					ret.colour = G.C.UI.TEXT_INACTIVE
					SMODS.calculate_effect(ret, (not context.repetition and context.other_card) or card)
				end
			end
		end,
	}

end

SMODS.Joker{
	key = 'e_m_increase',
	loc_txt = {
		name = '',
		text = {
		'Mult - {C:mult}+8{} Mult',
		'Bonus - {C:chips}+60{} Chips',
		'Glass - {C:green}1 in 8{} Chance',
		'Steel - {X:mult,C:white}X2{} Mult',
		'Stone - {C:chips}+100{} Chips',
		'Gold - {C:money}$6{}',
		'Lucky - {C:mult}+30{} Mult,',
		'{C:green}1 in 10{} Chance for {C:money}${}'
		}
	},
	rarity = 'sncuty_token',
	unlocked = true,
	discovered = true,
	no_collection = true,
	pos = {x = 4, y = 4}
}

function enchance_change(plus)
	if plus then
		G.P_CENTERS.m_mult.config.mult = 8
		G.P_CENTERS.m_bonus.config.bonus = 60
		G.P_CENTERS.m_glass.config.extra = 8
		G.P_CENTERS.m_steel.config.h_x_mult = 2
		G.P_CENTERS.m_stone.config.bonus = 100
		G.P_CENTERS.m_lucky.config.mult = 30
		G.P_CENTERS.m_lucky.config.extra.money_chance = 10
		-- had to lovely patch to change the chance
		G.P_CENTERS.m_gold.config.h_dollars = 6
		G.GAME.mart_in_play = true
	else
		G.P_CENTERS.m_mult.config.mult = 4
		G.P_CENTERS.m_bonus.config.bonus = 30
		G.P_CENTERS.m_glass.config.extra = 4
		G.P_CENTERS.m_steel.config.h_x_mult = 1.5
		G.P_CENTERS.m_stone.config.bonus = 50
		G.P_CENTERS.m_lucky.config.mult = 20
		G.P_CENTERS.m_lucky.config.extra.money_chance = 15
		G.P_CENTERS.m_gold.config.h_dollars = 3
		G.GAME.mart_in_play = false
	end

	if G.playing_cards then
		for k, card in pairs(G.playing_cards) do
			if SMODS.has_enhancement(card, "m_mult") then
				card.ability.mult = G.P_CENTERS.m_mult.config.mult
			elseif SMODS.has_enhancement(card, "m_bonus") then
				card.ability.bonus = G.P_CENTERS.m_bonus.config.bonus
			elseif SMODS.has_enhancement(card, "m_glass") then
				card.ability.extra = G.P_CENTERS.m_glass.config.extra
			elseif SMODS.has_enhancement(card, "m_steel") then
				card.ability.h_x_mult = G.P_CENTERS.m_steel.config.h_x_mult
			elseif SMODS.has_enhancement(card, "m_stone") then
				card.ability.bonus = G.P_CENTERS.m_stone.config.bonus
			elseif SMODS.has_enhancement(card, "m_lucky") then
				card.ability.mult = G.P_CENTERS.m_lucky.config.mult
				card.ability.extra.money_chance = G.P_CENTERS.m_lucky.config.extra.money_chance
			elseif SMODS.has_enhancement(card, "m_gold") then
				card.ability.h_dollars = G.P_CENTERS.m_gold.config.h_dollars
			end
		end
	end
end

local orig_main_menu = Game.main_menu
function Game:main_menu(change_context)
	if G.GAME.mart_in_play then
		enchance_change(false)
	end
	orig_main_menu(self, change_context)
end

local orig_run_start = Game.start_run
function Game:start_run(args)
	if G.GAME.mart_in_play then
		enchance_change(false)
	end
	orig_run_start(self, args)
end

SMODS.Joker {
	key = "martlet",
	loc_txt = {
		name = "Martlet",
		text = {
		'{C:attention}Enhancements{} have their',
		'{C:attention}values{} increased'
		}
	},
	atlas = "Main",
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 2, y = 0},
	config = {
		extra = {
			flat = 2,
			steel = 0.5,
			lucky = 1.5,
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_e_m_increase
		if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
		end
		return { vars = {  } }
	end,
	add_to_deck = function(self, card, from_debuff)
		enchance_change(true)
		card.ability.extra.inBuild = true
	end,
	update = function(self, card, from_debuff)
		if card.ability.extra.inBuild then
			enchance_change(true)
		end 
	end,
	remove_from_deck = function(self, card, from_debuff)
		card.ability.extra.inBuild = false
		enchance_change(false)
	end,
	calculate = function(self, card, context)
		if context.gameover then
			card.ability.extra.inBuild = false
			enchance_change(false)
		end
	end
}

SMODS.Joker{
	key = 'ceroba',
	loc_txt = {
		name = 'Ceroba',
		text = {
		'Gains {X:mult,C:white}X#1#{} Mult if played hand',
		'sets the {C:attention}score{} on {C:mult}fire{}',
		'{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}'
		}
	},
	atlas = 'Main',
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = {x = 3, y = 0},
	config = {
		extra={
			xmult = 1,
			xmult_gain = 0.25
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        
		if context.final_scoring_step and G.GAME.blind and not context.blueprint then
            if (hand_chips * mult >= G.GAME.blind.chips) then
				-- yeah, it's that easy
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
				return {
					message = "Burn!",
					colour = G.C.MULT
				}
			end
        end
	end
}

SMODS.Joker{
	key = 'chujin',
	loc_txt = {
		name = 'Chujin',
		text = {
		'After #2# {C:inactive}(#1#){} rounds,',
		'if {C:attention}last hand{} of round is',
		'a {C:tarot}Secret Hand{}, add {C:dark_edition}Negative{}',
		'to a random {C:attention}card{}',
		'{C:mult,E:2}Self destructs{}'
		}
	},
	atlas = 'Main',
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 4, y = 0},
	config = {
		extra={
			rounds_played = 0,
			round_req = 3,
			active = false
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.rounds_played, card.ability.extra.round_req } }
	end,
	
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			if (card.ability.extra.rounds_played < card.ability.extra.round_req) then
				card.ability.extra.rounds_played = card.ability.extra.rounds_played + 1
				return {
					message = card.ability.extra.rounds_played .. '/' .. card.ability.extra.round_req,
					colour = G.C.SECONDARY_SET.Tarot
				}
			else
				return {
					message = 'Active!',
					colour = G.C.SECONDARY_SET.Tarot
				}
			end
		end

		if context.hand_drawn and card.ability.extra.active ~= true then
			card.ability.extra.active = true
			local eval = function(card) return (card.ability.extra.rounds_played >= card.ability.extra.round_req) and G.GAME.current_round.hands_left == 1 end
			juice_card_until(card, eval, true)
		end

		if context.final_scoring_step and (card.ability.extra.rounds_played >= card.ability.extra.round_req) and not context.retrigger_joker then
			if played_secret_hand(context.poker_hands) and G.GAME.current_round.hands_left == 0 then
				local jined = pseudorandom_element(G.play.cards, pseudoseed("jin_negative"))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
						jined:set_edition({negative = true}, true)
						jined:juice_up()
						card:juice_up()
					return true
				end,
				}))
				delay(1)
				SMODS.calculate_effect({message = "I'm sorry...", colour = G.C.SECONDARY_SET.Tarot}, card)
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
			end
			card.ability.extra.active = false
			return nil
		end
	end

}
