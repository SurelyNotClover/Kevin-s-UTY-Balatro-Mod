
-- Ruins characters

SMODS.Joker{
	key = 'penilla',
	loc_txt = {
		name = 'Penilla',
		text = {
		'If played hand has {C:attention}5{} cards,',
		'add a random {C:attention}enchancement{}',
		'to a random card in it'
		}
	},
	atlas = 'Ruins',
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 0, y = 0},
	config = {
		extra = {

		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {  } }
	end,
	
	calculate = function(self, card, context)
		if context.before and #context.full_hand >= 5 then
			local canvas = pseudorandom_element(G.play.cards, pseudoseed('penilla'))
			canvas:set_ability(
					SMODS.poll_enhancement({ guaranteed = true, type_key = "penilla" }),
					true,
					false
				)
			canvas:juice_up()
			play_sound("tarot1")
			if context.blueprint then
				context.blueprint_card:juice_up()
			else
				card:juice_up()
			end
			return {
				message = "Sketched",
				colour = G.C.ATTENTION
			}
		end
	end
}

SMODS.Joker{
	key = 'crispy_cards',
	loc_txt = {
		name = '',
		text = {
		'Excluding {C:spectral}Ectoplasm{},',
		'{C:spectral}Hex{} and {C:spectral}Ouija{}',
		}
	},
	rarity = 'sncuty_token',
	unlocked = true,
	discovered = true,
	no_collection = true,
	pos = {x = 4, y = 4},
}

SMODS.ObjectType({
	key = "crispy_cards",
	default = "c_talisman",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.c_familiar)
		self:inject_card(G.P_CENTERS.c_grim)
		self:inject_card(G.P_CENTERS.c_incantation)
		self:inject_card(G.P_CENTERS.c_sigil)
		self:inject_card(G.P_CENTERS.c_talisman)
		self:inject_card(G.P_CENTERS.c_aura)
		self:inject_card(G.P_CENTERS.c_wraith)
		self:inject_card(G.P_CENTERS.c_immolate)
		self:inject_card(G.P_CENTERS.c_deja_vu)
		self:inject_card(G.P_CENTERS.c_trance)
		self:inject_card(G.P_CENTERS.c_medium)
		self:inject_card(G.P_CENTERS.c_cryptid)
	end,
})

SMODS.Joker{
	key = 'crispy_scroll',
	loc_txt = {
		name = 'Crispy Scroll',
		text = {
		'Casts a {C:spectral}Spectral{} card if',
		'played {C:attention}poker hand{} scores',
		'{X:tarot,C:white}X#1#{} the blind requirement',
		'{s:0.6,C:inactive}(Target is chosen randomly if needed){}'
		}
	},
	atlas = 'Ruins',
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	soul_pos = {x = 1, y = 1},
	pos = {x = 1, y = 0},
	config = {
		extra = {
			overkill_req = 2
		},
	},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_crispy_cards
        return {vars = { card.ability.extra.overkill_req } }
	end,

	calculate = function(self, card, context)
		if context.final_scoring_step and context.cardarea == G.jokers and (hand_chips * mult >= G.GAME.blind.chips * card.ability.extra.overkill_req) then
			SMODS.calculate_effect({message = 'RAAAAAAAAAHH!!', colour = G.C.MULT}, context.blueprint_card or card)
			G.E_MANAGER:add_event(Event({
				func = function()
					local spectral = SMODS.add_card({set = "crispy_cards", area = G.offscreen})
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blockable = false,
						func = function()
							if spectral.ability.max_highlighted or spectral.ability.name == 'Aura' then
								local select = pseudorandom_element(G.hand.cards, pseudoseed('randomhighlight'))
								G.hand:add_to_highlighted(select)
							end
							if context.blueprint then
								context.blueprint_card:juice_up()
							else
								card:juice_up()
							end
							G.FUNCS.use_card({ config = { ref_table = spectral } })
							return true
						end
					}))
					return true
				end
			}))
		elseif context.final_scoring_step and context.cardarea == G.jokers then
			SMODS.calculate_effect({message = {"!!???"}}, card)
		end
	end
}

SMODS.Joker{
	key = 'decibat',
	loc_txt = {
		name = 'Decibat',
		text = {
		'Upgrade the level of',
		'winning {C:attention}poker hand{}',
		'{C:mult,E:2}Self destructs{} if {C:attention}played hand{}',
		'sets the {C:attention}score{} on {C:mult}fire{}'
		}
	},
	atlas = 'Ruins',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 2, y = 0},
	config = {
		extra = {
			
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.overkill_req } }
	end,
	
	calculate = function(self, card, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.children.center:set_sprite_pos({x = 2, y = 0})
					return true
				end
			}))
		end

		if context.final_scoring_step and context.cardarea == G.jokers and (hand_chips * mult >= G.GAME.blind.chips) and not context.blueprint and not context.retrigger_joker then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.children.center:set_sprite_pos({x = 2, y = 2})
					return true
				end
			}))
			SMODS.calculate_effect({message = {"NOISE HURTS!"}}, card)
			delay(0.5)
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
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.children.center:set_sprite_pos({x = 2, y = 1})
					return true
				end
			}))
			return {
				card = self,
				level_up = G.GAME.last_hand_played,
				message = "hushh hushh"
			}
		end
	end
}

SMODS.Joker{
	key = 'pops',
	loc_txt = {
		name = 'Pops',
		text = {
		'{X:mult,C:white}X#1#{} Mult if scoring hand',
		'consists of a single suit but',
		'doesnt contain {C:attention}Flush{} and',
		'isnt a {C:attention}High Card{}'
		}
	},
	atlas = 'Ruins',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 3, y = 0},
	config = {
		extra = {
			xmult = 4
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.xmult} }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main and context.cardarea == G.jokers and #context.scoring_hand > 1 and not next(context.poker_hands['Flush']) then
			local first_card = context.scoring_hand[1].base.suit
			for i = 1, #context.scoring_hand do
				if not (context.scoring_hand[i]:is_suit(first_card) or SMODS.has_any_suit(context.scoring_hand[i])) then
					return nil
				end
			end
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
}