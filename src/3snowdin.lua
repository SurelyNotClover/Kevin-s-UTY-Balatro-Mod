
-- Snowdin Characters

SMODS.Joker{
	key = 'slurpy',
	loc_txt = {
		name = 'Slurpy',
		text = {
		'After {C:attention}selling #1# {C:inactive}(#2#){C:attention} consumables{},',
		'create {C:attention}Honeydew Coffee{}',
		'If you have {C:attention}Lakewarm Coffee{}',
		'at the end of shop, destroy it',
		'and turn into {C:attention}Silver Scarf{}'
		}
	},
	atlas = 'Snowdin',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	pos = {x = 0, y = 0},
	config = {
		extra = {
			sell_req = 10,
			sells_left = 10
		},
	},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_honeydew_coffee
		info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_silver_scarf
        return {vars = { card.ability.extra.sell_req, card.ability.extra.sells_left } }
	end,
	
	calculate = function(self, card, context)
		if context.end_of_round then
			local eval = function() return
				next(SMODS.find_card('j_sncuty_lakewarm_coffee'))
			end
            juice_card_until(card, eval, true)
		end

		if context.selling_card and not context.selling_self and card.ability.extra.sells_left ~= 0 and not context.blueprint and (context.card.ability.set == "Tarot" or context.card.ability.set == "Planet" or context.card.ability.set == "Spectral") then
			card.ability.extra.sells_left = card.ability.extra.sells_left - 1
			if card.ability.extra.sells_left >= 1 then
				return {
					message = card.ability.extra.sells_left .. '/' .. card.ability.extra.sell_req
				}
			else
				SMODS.add_card({set = "Joker", key = 'j_sncuty_honeydew_coffee', no_edition = true})
				SMODS.calculate_effect({ message = "TOO HOT!", colour = G.C.MULT }, card)
			end
		end

		if context.ending_shop and context.cardarea == G.jokers and next(SMODS.find_card('j_sncuty_lakewarm_coffee')) and not context.retrigger_joker then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card:juice_up(0.3, 0.5)
					card:flip()
					return true
				end,
				}))
				
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if card then
						card:set_ability('j_sncuty_silver_scarf')
					end
				return true
			end,
			}))
				
			delay(0.5)
				
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("tarot2")
					card:set_cost()
					card:flip()
				return true
			end,
			}))
				
			delay(0.25)
			
			SMODS.calculate_effect({ message = "Thank you!", colour = G.C.CHIPS }, card)
				
		end
	end
}

SMODS.Joker{
	key = 'honeydew_coffee',
	loc_txt = {
		name = 'Honeydew Coffee',
		text = {
			'{C:dark_edition}+1{} Joker slot',
			'After playing {C:attention}#1# {C:inactive}(#2#){} cards {C:attention}without scoring{},',
			'turn into {C:attention}Soggy Mitten{}',
			'{C:inactive}(1/5){}'
		}
	},
	atlas = 'Snowdin',
	rarity = 'sncuty_token',
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	pos = {x = 1, y = 0},
	config = {
		extra = {
			unscore_req = 20,
			unscores_left = 20
		},
	},
	loc_vars = function(self,info_queue,card)
		if not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_token_joker
        end
        return {vars = { card.ability.extra.unscore_req, card.ability.extra.unscores_left } }
	end,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == "unscored" and card.ability.extra.unscores_left ~= 0 then
			card.ability.extra.unscores_left = card.ability.extra.unscores_left - 1
			if card.ability.extra.unscores_left >= 1 then
				return {
					message = card.ability.extra.unscores_left .. '/' .. card.ability.extra.unscore_req,
					card = card
				}
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card:juice_up(0.3, 0.5)
						card:flip()
						return true
					end,
					}))
					
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						if card then
							card:set_ability('j_sncuty_soggy_mitten')
						end
					return true
				end,
				}))
					
				delay(0.5)
					
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("tarot2")
						card:set_cost()
						card:flip()
					return true
				end,
				}))
					
				delay(0.25)
					
				SMODS.calculate_effect({ message = "Take this"}, card)
					
			end
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
	end,

	in_pool = function(self,wawa,wawa2)
        return false
	end
}

SMODS.Joker{
	key = 'soggy_mitten',
	loc_txt = {
		name = 'Soggy Mitten',
		text = {
			'{C:dark_edition}+1{} Joker slot',
			'After {C:green}rerolling{} the shop {C:attention}#1# {C:inactive}(#2#){} times,',
			'turn into {C:attention}Snowdin Map{}',
			'{C:inactive}(2/5){}'
		}
	},
	atlas = 'Snowdin',
	rarity = 'sncuty_token',
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	pos = {x = 2, y = 0},
	config = {
		extra = {
			reroll_req = 10,
			rerolls_left = 10
		},
	},
	loc_vars = function(self,info_queue,card)
		if not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_token_joker
        end
        return {vars = { card.ability.extra.reroll_req, card.ability.extra.rerolls_left } }
	end,
	
	calculate = function(self, card, context)
		if context.reroll_shop then
			card.ability.extra.rerolls_left = card.ability.extra.rerolls_left - 1
			if card.ability.extra.rerolls_left >= 1 then
				return {
					message = card.ability.extra.rerolls_left .. '/' .. card.ability.extra.reroll_req
				}
			else
				G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card:juice_up(0.3, 0.5)
					card:flip()
					return true
				end,
				}))
					
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						if card then
							card:set_ability('j_sncuty_snowdin_map')
						end
						return true
				end,
				}))
					
				delay(0.5)
					
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("tarot2")
						card:set_cost()
						card:flip()
					return true
				end,
				}))
					
				delay(0.25)
				
				SMODS.calculate_effect({ message = "Take this"}, card)

			end
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
	end,

	in_pool = function(self,wawa,wawa2)
        return false
	end
}

SMODS.Joker{
	key = 'snowdin_map',
	loc_txt = {
		name = 'Snowdin Map',
		text = {
			'{C:dark_edition}+1{} Joker slot',
			'After {C:mult}destroying{} {C:attention}#1# {C:inactive}(#2#){} playing cards,',
			'turn into {C:attention}Matches{}',
			'{C:inactive}(3/5){}'
		}
	},
	atlas = 'Snowdin',
	rarity = 'sncuty_token',
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	pos = {x = 3, y = 0},
	config = {
		extra = {
			destroy_req = 10,
			destroys_left = 10
		},
	},
	loc_vars = function(self,info_queue,card)
		if not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_token_joker
        end
        return {vars = { card.ability.extra.destroy_req, card.ability.extra.destroys_left } }
	end,
	
	calculate = function(self, card, context)
		if context.remove_playing_cards then
			card.ability.extra.destroys_left = card.ability.extra.destroys_left - #context.removed
		if card.ability.extra.destroys_left >= 1 then
			return {
				message = card.ability.extra.destroys_left .. '/' .. card.ability.extra.destroy_req
			}
		else
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card:juice_up(0.3, 0.5)
					card:flip()
					return true
				end,
				}))
				
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						if card then
							card:set_ability('j_sncuty_matches')
						end
					return true
				end,
				}))
					
				delay(0.5)
					
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("tarot2")
						card:set_cost()
						card:flip()
					return true
				end,
				}))
					
				delay(0.25)

				SMODS.calculate_effect({ message = "Splendid!", colour = G.C.SUITS.Diamonds }, card)
				
			end
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
	end,

	in_pool = function(self,wawa,wawa2)
        return false
	end
}

SMODS.Joker{
	key = 'matches',
	loc_txt = {
		name = 'Matches',
		text = {
			'{C:dark_edition}+1{} Joker slot',
			'After playing a {C:tarot}Secret Hand{} {C:attention}#1# {C:inactive}(#2#){} times,',
			'turn into {C:attention}Lakewarm Coffee{}',
			'{C:inactive}(4/5){}'
		}
	},
	atlas = 'Snowdin',
	rarity = 'sncuty_token',
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	pos = {x = 4, y = 0},
	config = {
		extra = {
			play_req = 3,
			plays_left = 3
		},
	},
	loc_vars = function(self,info_queue,card)
		if not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_token_joker
        end
        return {vars = { card.ability.extra.play_req, card.ability.extra.plays_left } }
	end,
	
	calculate = function(self, card, context)
		if context.before and played_secret_hand(context.poker_hands)then
			card.ability.extra.plays_left = card.ability.extra.plays_left - 1
			if card.ability.extra.plays_left >= 1 then
				return {
					message = card.ability.extra.plays_left .. '/' .. card.ability.extra.play_req
				}
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card:juice_up(0.3, 0.5)
						card:flip()
						return true
					end,
					}))
					
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.1,
						func = function()
							if card then
								card:set_ability('j_sncuty_lakewarm_coffee')
							end
						return true
					end,
					}))
					
					delay(0.5)
					
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.2,
						func = function()
							play_sound("tarot2")
							card:set_cost()
							card:flip()
						return true
					end,
					}))
					
					delay(0.25)

					SMODS.calculate_effect({ message = "Lifesaver!"}, card)
				
			end
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
	end,

	in_pool = function(self,wawa,wawa2)
        return false
	end
}

SMODS.Joker{
	key = 'lakewarm_coffee',
	loc_txt = {
		name = 'Lakewarm Coffee',
		text = {
			'{C:dark_edition}+1{} Joker slot',
			'{C:inactive}(5/5){}'
		}
	},
	atlas = 'Snowdin',
	rarity = 'sncuty_token',
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	pos = {x = 0, y = 1},
	config = {
		extra = {
			
		},
	},
	loc_vars = function(self,info_queue,card)
		if not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_token_joker
        end
        return {vars = {  } }
	end,
	
	calculate = function(self, card, context)
		if context.ending_shop and next(SMODS.find_card('j_sncuty_slurpy')) then
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
	end,

	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
	end,

	in_pool = function(self,wawa,wawa2)
        return false
	end
}

SMODS.Joker{
	key = 'silver_scarf',
	loc_txt = {
		name = 'Silver Scarf',
		text = {
			'{X:tarot,C:white}X#1#{} blind requirements'
		}
	},
	atlas = 'Snowdin',
	rarity = 'sncuty_token',
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {x = 1, y = 1},
	config = {
		extra = {
			xblind = 0.6
		},
	},
	loc_vars = function(self,info_queue,card)
		if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
		end
		if not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_token_joker
        end
        return {vars = { card.ability.extra.xblind } }
	end,
	
	calculate = function(self, card, context)
		if context.setting_blind and not card.getting_sliced and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 1,
				func = function()
					G.GAME.blind.chips = math.floor(G.GAME.blind.chips * card.ability.extra.xblind)
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

					local chips_UI = G.hand_text_area.blind_chips
					G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
					G.HUD_blind:recalculate()
					chips_UI:juice_up()
					
					SMODS.calculate_effect({ message = {""}, sound = "xchips", colour = G.C.CHIPS }, card)
			return true end }))
		end
	end,

	in_pool = function(self,wawa,wawa2)
        return false
	end
}

SMODS.Joker{
	key = 'mo',
	loc_txt = {
		name = 'Mo',
		text = {
		'Lose {C:money}$#1#{} at end of round',	
		'After {C:attention}3{} {C:inactive}(#2#){} rounds, turn into',
		'{C:attention}Mo Stand{} at the end of {C:attention}Shop{}'
		}
	},
	atlas = 'Snowdin',
	rarity = 2,
	cost = 6,
	no_pool_flag = 'mo_stand_owned',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	pos = {x = 2, y = 1},
	config = {
		extra={
		money_loss = 10,
		rounds_left = 3
		},
	},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_mostand
		return {vars = {card.ability.extra.money_loss, card.ability.extra.rounds_left} }
	end,
	
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not (card.ability.extra.rounds_left <= 0) then
			card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
			ease_dollars(-card.ability.extra.money_loss)
			
			if card.ability.extra.rounds_left > 0 then
				if card.ability.extra.rounds_left > 1 then
				return {
				message = card.ability.extra.rounds_left .. ' Rounds left',
				colour = G.C.CHIPS
				}
				end
				if card.ability.extra.rounds_left == 1 then
				return {
				message = card.ability.extra.rounds_left .. ' Round left',
				colour = G.C.CHIPS
				}
				end
			end

			if card.ability.extra.rounds_left <= 0 then
				local eval = function(card) return card.config.center.key == 'j_sncuty_mo' end
				juice_card_until(card, eval, true)
				SMODS.calculate_effect({ message = 'Active!', colour = G.C.CHIPS }, card)
			end
		end
			
		if context.ending_shop and card.ability.extra.rounds_left <= 0 and not context.retrigger_joker then
			
			G.E_MANAGER:add_event(Event({
			func = function()
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
				card:flip()
				return true
			end,
			}))
			
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if card then
						card:set_ability('j_sncuty_mostand')
					end
				return true
			end,
			}))
			
			delay(0.5)
			
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("tarot2")
					card:set_cost()
					card:flip()
				return true
			end,
			}))

			G.GAME.pool_flags.mo_stand_owned = true
			
			delay(0.25)
			
			SMODS.calculate_effect({ message = 'Upgrade!', colour = G.C.CHIPS }, card)
			
		end
	end
}

--[[

	Joker transformation code: somethingcom515 on Discord

]]

SMODS.Joker{
	key = 'mostand',
	loc_txt = {
		name = 'Mo Stand',
		text = {
		'Earn {C:money}$#1#{} at',
		'end of round'
		}
	},
	atlas = 'Snowdin',
	rarity = 'sncuty_token',
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	pos = {x = 3, y = 1},
	config = {
		extra={
		money_gain = 15
		},
	},
	loc_vars = function(self,info_queue,card)
		if not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_token_joker
        end
		if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
		end
		return {vars = {card.ability.extra.money_gain} }
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.mo_stand_owned = true
	end,
	
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.mo_stand_owned = false
	end,

	calc_dollar_bonus = function(self,card)
        return card.ability.extra.money_gain
    end,
	
	in_pool = function(self,wawa,wawa2)
        return false
	end,
	
}

SMODS.Joker{
	key = 'trihecta',
	loc_txt = {
		name = 'TriHecTa',
		text = {
		'Gains {C:chips}+#1#{} Chips',
		'if played hand is a',
		'{C:attention}Three of a Kind{}',
		'{C:inactive}(Currently {C:chips}+#2#{}{C:inactive} Chips){}'
		}
	},
	atlas = 'Snowdin',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = {x = 4, y = 1},
	config = {
		extra={
		chips = 0,
		chip_gain = 15
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.chip_gain, card.ability.extra.chips} }
	end,
	
	calculate = function(self, card, context)
		if context.before and context.scoring_name == "Three of a Kind" then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
			return{
			message = 'Upgrade!',
			colour = G.C.CHIPS
			}
		end
		
		if context.joker_main then
			return{
				chips = card.ability.extra.chips
			}
		end
	end
}

SMODS.Joker{
	key = 'shufflers',
	loc_txt = {
		name = 'The Shufflers',
		text = {
		'{C:green}#1# in #2#{} chance for {X:mult,C:white}X#3#{} Mult',
		'{C:green}#1# in #2#{} chance to create a {C:planet}Planet{} card',
		'{C:green}#1# in #2#{} chance to create a random {C:attention}Tag{}',
		'at end of round'
		}
	},
	atlas = 'Snowdin',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 0, y = 2},
	config = {
		extra = {
			chance = 3,
			xmult = 2
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { G.GAME.probabilities.normal, card.ability.extra.chance, card.ability.extra.xmult, } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main and context.cardarea == G.jokers then
			if pseudorandom("shufflers_xmult") < G.GAME.probabilities.normal/card.ability.extra.chance then
				SMODS.calculate_effect({ xmult = card.ability.extra.xmult }, context.blueprint_card or card)
			end

			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				if pseudorandom("shufflers_planet") < G.GAME.probabilities.normal/card.ability.extra.chance then
					SMODS.calculate_effect({ message = {"+1 Planet"}, colour = G.C.CHIPS}, context.blueprint_card or card)
					G.E_MANAGER:add_event(Event({
						trigger = "before",
						delay = 0.1,
						func = function()
							if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
								SMODS.add_card({set = "Planet"})
							end
						return true
					end,
					}))
				end
			end
			return nil, true
		end
		if context.end_of_round and context.cardarea == G.jokers then
			if pseudorandom("shufflers_tag") < G.GAME.probabilities.normal/card.ability.extra.chance then
				SMODS.calculate_effect({ message = {"+1 Tag"}}, context.blueprint_card or card)
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.1,
					func = function()
						-- function shamelessly stolen from Paperback Mod
						PB_UTIL.add_tag(PB_UTIL.poll_tag("shufflers_tag"))
					return true
				end,
				}))
			else
				SMODS.calculate_effect({ message = {"Nope!"}}, context.blueprint_card or card)
			end
			return nil, true
		end
	end,
}

SMODS.Joker{
	key = 'flame_guy',
	loc_txt = {
		name = 'Flame Guy',
		text = {
		'Earn {C:money}$#1#{} for every',
		'destroyed {C:attention}playing card{}'
		}
	},
	atlas = 'Snowdin',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = {x = 1, y = 2},
	config = {
		extra = {
			money = 3,
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.money} }
	end,
	
	calculate = function(self, card, context)
		if context.remove_playing_cards then
			return {
				dollars = card.ability.extra.money * #context.removed
			}
		end
	end
}

SMODS.Joker{
	key = 'honeydew',
	loc_txt = {
		name = 'Honeydew Girl',
		text = {
		'Gains {C:chips}+#1#{} Chips for',
		'each consumable {C:attention}sold{}',
		'{C:inactive}(Currently {C:chips}+#2#{} {C:inactive}Chips{}'
		}
	},
	atlas = 'Snowdin',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = {x = 2, y = 2},
	config = {
		extra = {
		chips = 0,
		chip_gain = 6,
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.chip_gain, card.ability.extra.chips} }
	end,
	calculate = function(self, card, context)
		if context.selling_card and not context.selling_self and not context.blueprint and context.card.ability.consumeable then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
			return {
				message = 'Upgrade!',
				color = G.C.CHIPS
			}
		end
		
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				chips = card.ability.extra.chips
			}
		end
	end
}