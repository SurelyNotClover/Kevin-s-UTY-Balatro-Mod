
-- Dunes Characters

-- Dunebud is_suit hook

local orig_is_suit = Card.is_suit
function Card.is_suit(self, suit, bypass_debuff, flush_calc)
    local is_stone = SMODS.has_enhancement(self, "m_stone") or false
	if not (self.debuff and not bypass_debuff) and (next(SMODS.find_card('j_sncuty_dunebud'))) and is_stone then
        if SMODS.find_card('j_sncuty_dunebud') then
            return true
        end
	end
    return orig_is_suit(self, suit, bypass_debuff, flush_calc)
end

SMODS.Joker{
	key = 'dunebud',
	loc_txt = {
		name = 'Dunebud',
		text = {
		'{C:attention}Stones{} can be used',
		'as all suits'
		}
	},
	atlas = 'Dunes',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 0, y = 0},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return {vars = { } }
	end,
}

SMODS.Joker{
	key = 'tnt_man',
	loc_txt = {
		name = 'TNT Man',
		text = {
		'{X:mult,C:white}X#1#{} Mult on final',
		'hand of round',
		'{C:mult,E:2}self destructs{}'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pixel_size = {  h = 69 },
	pos = {x = 1, y = 0},
	config = {
		extra = {
			xmult = 10
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.xmult } }
	end,
	
	calculate = function(self, card, context)
		if context.after and not context.blueprint then
			local eval = function() return
				G.GAME.current_round.hands_left == 1
			end
            juice_card_until(card, eval, true)
		end
		if context.joker_main and G.GAME.current_round.hands_left == 0 then
			SMODS.calculate_effect({ xmult = card.ability.extra.xmult }, context.blueprint_card or card)
			delay(0.5)
			if not context.blueprint then
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
		end
	end
}

SMODS.Joker{
	key = 'stresso_miner',
	loc_txt = {
		name = 'Stresso',
		text = {
		'Played {C:attention}Stone{} cards',
		'give {C:mult}+#1#{} Mult when scored'
		}
	},
	atlas = 'Dunes',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 2, y = 0},
	config = {
		extra = {
			mult = 5
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.mult } }
	end,
	
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual and SMODS.has_enhancement(context.other_card, "m_stone") then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

SMODS.Joker{
	key = 'tall_miner',
	loc_txt = {
		name = 'Tall Miner',
		text = {
		'{C:green}#1# in #2#{} chance for played',
		'{C:attention}Stone{} cards to give {C:money}$#3#{}',
		'when scored'
		}
	},
	atlas = 'Dunes',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pixel_size = { w = 51},
	pos = {x = 3, y = 0},
	config = {
		extra = {
			chance = 4,
			money = 3
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { G.GAME.probabilities.normal, card.ability.extra.chance, card.ability.extra.money } }
	end,
	
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual and SMODS.has_enhancement(context.other_card, "m_stone") then
			if pseudorandom("tall_money") < G.GAME.probabilities.normal/card.ability.extra.chance then
				return {
					dollars = card.ability.extra.money
				}
			end
		end
	end
}

SMODS.Joker{
	key = 'matt_miner',
	loc_txt = {
		name = 'Matt',
		text = {
		'Retrigger each played',
		'{C:attention}Stone{} card once'
		}
	},
	atlas = 'Dunes',
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 4, y = 0},
	config = {
		extra = {
			repetitions = 1
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { } }
	end,
	
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and SMODS.has_enhancement(context.other_card, "m_stone") then
			return {
				message = 'Again!',
				repetitions = card.ability.extra.repetitions,
				card = card
			}
		end
	end
}

SMODS.Joker{
	key = 'gilbert',
	loc_txt = {
		name = 'Gilbert',
		text = {
		'{C:attention}Stone{} cards ignore',
		'selection limit'
		}
	},
	atlas = 'Dunes',
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 0, y = 1},
	config = {
		extra = {
			
		},
	},
	loc_vars = function(self,info_queue,card)
		if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
		end
        return {vars = {  } }
    end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.stones_ignore_selection = true
		-- everything is done through a lovely patch
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:unhighlight_all()
		G.GAME.stones_ignore_selection = false
	end,
}

SMODS.Joker{
	key = 'snake_miner',
	loc_txt = {
		name = 'Snake Miner',
		text = {
		'If {C:attention}first hand{} of round',
		'has only {C:attention}1 Stone{} card,',
		'destroy it and add a random {C:attention}seal{}',
		'to a random {C:attention}playing card{} in hand'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 1, y = 1},
	config = {
		extra = {
			
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { } }
	end,
	
	calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 end
            juice_card_until(card, eval, true)
		end
		
		if context.destroying_card and not context.blueprint and not context.retrigger_joker then
			if #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 and SMODS.has_enhancement(context.full_hand[1], "m_stone") then
				local sealed = pseudorandom_element(G.hand.cards, pseudoseed('snake_miner'))
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.4,
					func = function()
						card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Nom", colour = G.C.ATTENTION})
						sealed:set_seal(
							SMODS.poll_seal({ guaranteed = true, type_key = "snake_miner" }),
							true,
							false
						)
						sealed:juice_up()
						play_sound("gold_seal", 1.2, 0.4)
						card:juice_up()
						
						return true
					end,
				}))
				return true
			end
			return nil
		end
	end
}

SMODS.Joker{
	key = 'giftshopper',
	loc_txt = {
		name = 'Giftshopper',
		text = {
		'+#1# {C:attention}Booster Pack{} slot',
		'available in the shop'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 2, y = 1},
	config = {
		extra = {
			booster_slots = 1
		},
	},
	loc_vars = function(self,info_queue,card)
		if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
		end
        return {vars = {math.min(25, card.ability.extra.booster_slots)} }
	end,
	
	calculate = function(self, card, context)
		
	end,

	add_to_deck = function(self, card, from_debuff)
		local mod = math.min(25, card.ability.extra.booster_slots)
		SMODS.change_booster_limit(mod)
	end,
	
	remove_from_deck = function(self, card, from_debuff)
		local mod = math.min(25, card.ability.extra.booster_slots)
		SMODS.change_booster_limit(-mod)
	end,
}

SMODS.Joker{
	key = 'rosa',
	loc_txt = {
		name = 'Rosa',
		text = {
		'Played cards with',
		'{C:hearts}Heart{} suit give',
		'{X:mult,C:white}X#1#{} Mult when scored'
		}
	},
	atlas = 'Dunes',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 3, y = 1},
	config = {
		extra={
			xmult = 1.2
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.xmult} }
	end,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and (context.other_card:is_suit("Hearts") or SMODS.has_any_suit(context.other_card)) then
			return{
				xmult = card.ability.extra.xmult,
				card = card,
			}
		end
	end
}

SMODS.Joker{
	key = 'pedla',
	loc_txt = {
		name = 'Pedla',
		text = {
		'{C:green}#1# in #2#{} chance for played cards{}',
		'with {C:diamonds}Diamond{} suit to create',
		'a {C:tarot}Tarot{} card when scored'
		}
	},
	atlas = 'Dunes',
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 4, y = 1},
	config = {
		extra = {
			tarot_chance = 4
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { G.GAME.probabilities.normal, card.ability.extra.tarot_chance } }
	end,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and (context.other_card:is_suit("Diamonds") or SMODS.has_any_suit(context.other_card)) then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				if pseudorandom("pedla_tarot") < G.GAME.probabilities.normal/card.ability.extra.tarot_chance or context.retrigger_joker then
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.25,
						func = function()
							if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
								play_sound('timpani')
								SMODS.add_card({set = "Tarot"})
								if context.blueprint then
									context.blueprint_card:juice_up(0.3, 0.5)
								else
									card:juice_up(0.3, 0.5)
								end
							end
							return true
						end
					}))
					return true
				end
			end
		end
	end
}

SMODS.Joker{
	key = 'violleta',
	loc_txt = {
		name = 'Violleta',
		text = {
		'Retrigger each played',
		'{C:attention}enchanced{} card with',
		'{C:spades}Spade{} or {C:clubs}Club{} suit'
		}
	},
	atlas = 'Dunes',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 0, y = 2},
	config = {
		extra = {
			repetitions = 1
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { } }
	end,
	
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and next(SMODS.get_enhancements(context.other_card)) and (context.other_card:is_suit('Spades') or context.other_card:is_suit('Clubs')) then
			for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].config.center ~= G.P_CENTERS.c_base then
					return {
						message = 'Again!',
						repetitions = card.ability.extra.repetitions,
						card = card
					}
				end
			end
		end
	end
}

SMODS.Joker{
	key = 'byte',
	loc_txt = {
		name = 'Byte',
		text = {
		'{C:attention}+#1#{} card available',
		'in {C:attention}Booster Packs{}'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 1, y = 2},
	config = {
		extra = {
			pack_size = 1
		},
	},
	loc_vars = function(self,info_queue,card)
		if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
		end
        return {vars = { card.ability.extra.pack_size } }
	end,
	add_to_deck = function(self,card,from_debuff)
		G.GAME.extra_pack_size = G.GAME.extra_pack_size + card.ability.extra.pack_size
	end,
	remove_from_deck = function(self,card,from_debuff)
		G.GAME.extra_pack_size = G.GAME.extra_pack_size - card.ability.extra.pack_size
	end
}

local orig_use_card = G.FUNCS.use_card
function G.FUNCS.use_card(e, mute, nosave)
	local card = e.config.ref_table
	if card.ability.consumeable and card.ability.set == 'Tarot' then
		G.GAME.last_used_tarot = card.config.center_key
	end
	orig_use_card(e, mute, nosave)
end

SMODS.Joker{
	key = 'fortune_teller',
	loc_txt = {
		name = 'Fortune Teller',
		text = {
		'Once per round,',
		'{C:green}#1# in #2#{} chance to copy',
		'the used {C:tarot}Tarot{} card',
		'{C:inactive}(#3#){}'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 2, y = 2},
	config = {
		extra = {
			copy_chance = 4,
			active_text = 'Active!',
			active = 1
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { G.GAME.probabilities.normal, card.ability.extra.copy_chance, card.ability.extra.active_text } }
	end,
	
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == "Tarot" and not context.consumeable.beginning_end and (card.ability.extra.active ~= 0 or context.retrigger_joker) then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				if (pseudorandom("fortune_teller") < G.GAME.probabilities.normal/card.ability.extra.copy_chance) or context.retrigger_joker then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.5,
						func = function()
							if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
								SMODS.add_card({set = "Tarot", key = G.GAME.last_used_tarot})
							end
							return true
						end,
					}))
					card.ability.extra.active = 0
					card.ability.extra.active_text = 'Inactive'
					return {
						message = "Copied!",
						colour = G.C.SECONDARY_SET.Tarot
					}
				end
			end
		end

		if context.end_of_round and not context.blueprint and not context.retrigger_joker and card.ability.extra.active ~= 1 then
			card.ability.extra.active = 1
			card.ability.extra.active_text = 'Active!'
			SMODS.calculate_effect({message = "Active!", colour = G.C.SECONDARY_SET.Tarot}, card)
		end
	end
}

SMODS.Joker{
	key = 'corn_chowder',
	loc_txt = {
		name = 'Corn Chowder',
		text = {
		'Sell this to give a random {C:attention}playing card{}',
		'in your {C:attention}deck{} a random {C:attention}edition{} for every',
		'round played {C:inactive}(#1#){} with this'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	pos = {x = 3, y = 2},
	config = {
		extra = {
		rounds_played = 0
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.rounds_played} }
	end,
	
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.rounds_played = card.ability.extra.rounds_played + 1
			if card.ability.extra.rounds_played == 1 then
				return{
					message = card.ability.extra.rounds_played .. ' Round',
					colour = G.C.MONEY
				}
			else
				return{
					message = card.ability.extra.rounds_played .. ' Rounds',
					colour = G.C.MONEY
				}
			end
		end

		if context.selling_self and not context.blueprint and not context.retrigger_joker then
			if card.ability.extra.rounds_played > 0 then
				local nonsealeditionedcards = {}
				for k, v in pairs(G.deck.cards) do
    				if not v.edition or v.seal then
        				table.insert(nonsealeditionedcards, v)
    				end
				end
				for i = 1, card.ability.extra.rounds_played do
					local corned = pseudorandom_element(nonsealeditionedcards, pseudoseed('corn_chowder'))
					local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, nil, true, true,
					{'e_holo', 'e_foil', 'e_polychrome'})
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.1,
						func = function()
							if not corned.edition then
								corned:set_edition(
									edition,
									true
								)
							end
						card:juice_up()
						card.ability.extra.rounds_played = card.ability.extra.rounds_played - 1
						return true
					end,
					}))
				end
				if card.ability.extra.rounds_played == 0 and not context.retrigger_joker then
					return {
						message = 'Nom Nom',
						colour = G.C.Money
					}
				end
			end
		end
	end
}

SMODS.Joker{
	key = 'ace',
	loc_txt = {
		name = 'Ace',
		text = {
		'{X:mult,C:white}X#1#{} Mult for every {C:attention}Ace{}',
		'in {C:attention}hand{} and {C:attention}deck{}',
		'{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 4, y = 2},
	config = {
		extra = {
			xmult_ace = 0.25,
			xmult = 1
		},
	},
	loc_vars = function(self,info_queue,card)
		local aces = {}
		if G.deck and G.deck.cards then
			for k, v in pairs(G.deck.cards) do
				if v:get_id() == 14 then
					table.insert(aces, v)
				end
			end
		end
		if G.hand and G.hand.cards then
			for k, v in pairs(G.hand.cards) do
				if v:get_id() == 14 then
					table.insert(aces, v)
				end
			end
		end
        return {vars = { card.ability.extra.xmult_ace, card.ability.extra.xmult + (#aces * card.ability.extra.xmult_ace) } }
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			local aces = {}
			for k, v in pairs(G.deck.cards) do
				if v:get_id() == 14 then
					table.insert(aces, v)
				end
			end
			for k, v in pairs(G.hand.cards) do
				if v:get_id() == 14 then
					table.insert(aces, v)
				end
			end
			return{
				xmult = card.ability.extra.xmult + (#aces * card.ability.extra.xmult_ace)
			}
		end
	end,
}

local old_set_cost = Card.set_cost
function Card:set_cost()
    old_set_cost(self)
    if G.GAME.uty_heist then
		if self.ability.set ~= "Voucher" then
        	self.cost = 0
		end
    end
end

SMODS.Joker{
	key = 'mooch',
	loc_txt = {
		name = 'Mooch',
		text = {
		'All items, but {C:attention}Vouchers{}',
		'in the shop are {C:attention}free{}',
		'{C:green}#1# in #2#{} chance to set money to {C:money}$-#3#{}',
		'and {C:mult,E:2}self destruct{} when stealing'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	pos = {x = 0, y = 3},
	config = {
		extra = {
			chance = 10,
			debt = 10
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {G.GAME.probabilities.normal, card.ability.extra.chance, card.ability.extra.debt } }
    end,
	calculate = function(self, card, context)
		if (context.buying_card or context.open_booster) and context.card ~= card and not context.retrigger_joker then
			if pseudorandom('mooch_steal') < G.GAME.probabilities.normal/card.ability.extra.chance then
				G.GAME.uty_heist = false
				SMODS.calculate_effect({message = 'Jailed!', G.C.UI.TEXT_INACTIVE}, card)
				G.E_MANAGER:add_event(Event({
					func = function()
						card.children.center:set_sprite_pos({x = 3, y = 4})
						return true
					end
				}))
				delay(2)
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
				delay(1)
				ease_dollars(-(G.GAME.dollars + card.ability.extra.debt))
			else
				SMODS.calculate_effect({message = 'Safe!'}, card)
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.GAME.uty_heist = true
        if G.shop_booster and G.shop_booster.cards then
            for i = 1, #G.shop_booster.cards do
                G.shop_booster.cards[i]:set_cost()
            end
        end
		if G.shop_jokers and G.shop_jokers.cards then
			for i = 1, #G.shop_jokers.cards do
                G.shop_jokers.cards[i]:set_cost()
            end
		end
	end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.uty_heist = false
        if G.shop_booster and G.shop_booster.cards then
            for i = 1, #G.shop_booster.cards do
                G.shop_booster.cards[i]:set_cost()
            end
        end
		if G.shop_jokers and G.shop_jokers.cards then
			for i = 1, #G.shop_jokers.cards do
                G.shop_jokers.cards[i]:set_cost()
            end
		end
	end,
}

SMODS.Joker{
	key = 'ed',
	loc_txt = {
		name = 'Ed',
		text = {
		'{X:mult,C:white}X#1#{} Mult,',
		'{C:attention}-#2#{} hand size'
		}
	},
	atlas = 'Dunes',
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	display_size = { w = 71 * 1.15, h = 95 * 1.15 },
	pos = {x = 1, y = 3},
	config = {
		extra = {
			xmult = 4,
			hand_size = 2
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.xmult, card.ability.extra.hand_size } }
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return{
				xmult = card.ability.extra.xmult
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
}

SMODS.Joker{
	key = 'gamer',
	loc_txt = {
		name = 'Gamer',
		text = {
		'Gains {C:money}$#1#{} at end of round',
		'if winning hand contains',
		'{C:attention}Three of a Kind{} and {C:attention}#2#{}',
		'Rank increases when triggered',
		'{C:inactive}(Currently {C:money}$#3#{C:inactive})'
		}
	},
	atlas = 'Dunes',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {x = 2, y = 3},
	config = {
		extra = {
			money_gain = 1,
			money = 0,
			current_rank = 14,
			rank_text = "Ace",
			triggered = false
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.money_gain, card.ability.extra.rank_text, card.ability.extra.money } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			card.ability.extra.triggered = false
			if next(context.poker_hands["Three of a Kind"]) then
				for i = 1, #context.scoring_hand do
					if context.scoring_hand[i]:get_id() == card.ability.extra.current_rank then
						card.ability.extra.triggered = true
						return true
					end
				end
				return false
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and card.ability.extra.triggered == true then
			card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_gain

			if card.ability.extra.current_rank >= 14 then
				card.ability.extra.current_rank = 2
			else
				card.ability.extra.current_rank = card.ability.extra.current_rank + 1
			end

			if card.ability.extra.current_rank >= 2 and card.ability.extra.current_rank < 11 then
				card.ability.extra.rank_text = card.ability.extra.current_rank
			elseif card.ability.extra.current_rank == 11 then
				card.ability.extra.rank_text = "Jack"
			elseif card.ability.extra.current_rank == 12 then
				card.ability.extra.rank_text = "Queen"
			elseif card.ability.extra.current_rank == 13 then
				card.ability.extra.rank_text = "King"
			elseif card.ability.extra.current_rank == 14 then
				card.ability.extra.rank_text = "Ace"
			end

			return{
				message = "Upgrade!",
				colour = G.C.MONEY
			}
		end
	end,

	calc_dollar_bonus = function(self,card)
        return ((card.ability.extra.money > 0) and card.ability.extra.money)
    end,
}

SMODS.Joker{
	key = 'blackjack',
	loc_txt = {
		name = 'Blackjack',
		text = {
		'Every second {C:attention}High Card{}',
		'played lose {C:money}$#1#{} and',
		'gain {C:chips}+#2#{} Hand'
		}
	},
	atlas = 'Dunes',
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 3, y = 3},
	config = {
		extra = {
		money_loss = 2,
		hands_played = 0,
		hand_gain = 1
		},
	},
	loc_vars = function(self,info_queue,card)
		if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
		end
        return {vars = {card.ability.extra.money_loss, card.ability.extra.hand_gain} }
    end,
	calculate = function(self, card, context)
		if context.before and context.scoring_name == "High Card" and not context.retrigger_joker then
			card.ability.extra.hands_played = card.ability.extra.hands_played + 1
		end
		
		if context.before and card.ability.extra.hands_played >= 2 and not context.retrigger_joker then
			ease_dollars(-card.ability.extra.money_loss)
			ease_hands_played(card.ability.extra.hand_gain)
			card.ability.extra.hands_played = 0
			return {
				message = '+1 Hand',
				colour = G.C.CHIPS
			}
		end
		
		if context.end_of_round and context.cardarea and card.ability.extra.hands_played ~= 0 and not context.retrigger_joker then
			card.ability.extra.hands_played = 0
			SMODS.calculate_effect({ message = "Reset", colour = G.C.RED }, card)
		end
	end
}
