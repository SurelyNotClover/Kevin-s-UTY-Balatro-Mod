
-- Steamworks Characters

SMODS.Joker{
	key = 'manta_bot',
	loc_txt = {
		name = 'Manta Bot',
		text = {
		'Gains {C:mult}+#1#{} Mult',
		'if played hand',
		'contains a {C:attention}Straight{}',
		'{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult){}'
		}
	},
	atlas = 'Steamworks',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = {x = 0, y = 0},
	config = {
		extra = {
			mult_gain = 2,
			mult = 0
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
	end,
	
	calculate = function(self, card, context)
		if context.before and next(context.poker_hands["Straight"]) and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				message = 'Upgrade!',
				colour = G.C.MULT
			}
		end

		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult
			}
		end
	end,
}

SMODS.Joker{
	key = 'jandroid',
	loc_txt = {
		name = 'Jandroid',
		text = {
		'{X:mult,C:white}X#1#{} Mult if every {C:attention}scored{}',
		'{C:attention}card{} has an {C:attention}Enhancement{}'
		}
	},
	atlas = 'Steamworks',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 1, y = 0},
	config = {
		extra = {
			xmult = 2
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.xmult } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main and context.cardarea == G.jokers then
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].config.center == G.P_CENTERS.c_base then
					return nil
				end
			end
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end,
}

SMODS.Joker{
	key = 'steam_hermit',
	loc_txt = {
		name = 'Steam Hermit',
		text = {
		'Gain {C:gold}$#1#{} for every',
		'used {C:tarot}Tarot{} card',
		}
	},
	atlas = 'Steamworks',
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
			tarot_money = 1,
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.tarot_money } }
	end,
	
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == "Tarot" and not context.consumeable.beginning_end and not context.blueprint then
			return {
				dollars = card.ability.extra.tarot_money
			}
		end
	end,
}

SMODS.Joker{
	key = 'macro_froggit',
	loc_txt = {
		name = 'Macro Froggit',
		text = {
		'{C:white,X:chips}X#1#{} Chips',
		'{C:green}#2# in #3#{} chance this',
		'card is destroyed',
		'at end of round',
		}
	},
	atlas = 'Steamworks',
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	pixel_size = { w = 71, h = 79 },
	display_size = { w = 71 * 1.2, h = 79 * 1.2 },
	pos = {x = 3, y = 0},
	config = {
		extra = {
			xchips = 3,
			chance = 8
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.xchips, G.GAME.probabilities.normal, card.ability.extra.chance } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xchips = card.ability.extra.xchips
			}
		end
		if context.end_of_round and context.cardarea == G.jokers and not (context.blueprint or context.retrigger_joker) then
			if pseudorandom("macro_death") < G.GAME.probabilities.normal/card.ability.extra.chance then
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
								G.GAME.pool_flags.macro_froggit = false
								G.GAME.pool_flags.giga_froggit = true
								return true;
							end
						}))
						return true
					end
				}))
			else
				return {
					message = "Safe!"
				}
			end
		end
	end,
	in_pool = function(self, args)
        return (not G.GAME.pool_flags.micro_froggit and G.GAME.pool_flags.macro_froggit)
    end
}

SMODS.Joker{
	key = 'giga_froggit',
	loc_txt = {
		name = 'Giga Froggit',
		text = {
		'Every played card',
		'gives {C:white,X:chips}X#1#{} Chips',
		}
	},
	atlas = 'Ribbit',
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	display_size = { w = 90 * 0.9, h = 183 * 0.9 },
	pos = {x = 0, y = 0},
	config = {
		extra = {
			xchips = 2
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { card.ability.extra.xchips } }
	end,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			return {
				xchips = card.ability.extra.xchips
			}
		end
	end,
	in_pool = function(self, args)
        return G.GAME.pool_flags.giga_froggit
    end
}

SMODS.Joker{
	key = 'guardener',
	loc_txt = {
		name = 'Guardener',
		text = {
		'If {C:attention}poker hand{} contains a',
		'{C:diamonds}Diamond{} card, {C:clubs}Club{} card,',
		'{C:hearts}Heart{} card, and {C:spades}Spade card',
		'create a random {C:spectral}Spectral{} card',
		}
	},
	atlas = 'Steamworks',
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 4, y = 0},
	config = {
		extra = {
			
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = {  } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            if suits["Hearts"] > 0 and
                suits["Diamonds"] > 0 and
                suits["Spades"] > 0 and
                suits["Clubs"] > 0 then
					SMODS.calculate_effect({message = {"+1 Spectral"}, colour = G.C.SECONDARY_SET.Spectral}, card)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.25,
						func = function()
							if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
								play_sound('timpani')
								SMODS.add_card({set = "Spectral", area = G.consumeables})
								if context.blueprint then
									context.blueprint_card:juice_up(0.3, 0.5)
								else
									card:juice_up(0.3, 0.5)
								end
							end
							return true
						end
					}))
				return nil, true
            end
        end
	end,
}

SMODS.Joker{
	key = 'lil_bots',
	loc_txt = {
		name = 'Lil Bots',
		text = {
		'{C:green}#1# in #2#{} chance for {C:mult}+#3#{} Mult',
		'{C:green}#1# in #2#{} chance for {C:chips}+#4#{} Chips',
		'{C:green}#1# in #2#{} chance to create a {C:tarot}Tarot{} card'
		}
	},
	atlas = 'Steamworks',
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 0, y = 1},
	config = {
		extra = {
			chance = 3,
			mult = 10,
			chips = 80
		},
	},
	loc_vars = function(self,info_queue,card)
        return {vars = { G.GAME.probabilities.normal, card.ability.extra.chance, card.ability.extra.mult, card.ability.extra.chips } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main and context.cardarea == G.jokers then
			if pseudorandom("lil_bots_mult") < G.GAME.probabilities.normal/card.ability.extra.chance then
				SMODS.calculate_effect({ mult = card.ability.extra.mult }, context.blueprint_card or card)
			end

			if pseudorandom("lil_bots_chips") < G.GAME.probabilities.normal/card.ability.extra.chance then
				SMODS.calculate_effect({ chips = card.ability.extra.chips }, context.blueprint_card or card)
			end

			if pseudorandom("lil_bots_tarot") < G.GAME.probabilities.normal/card.ability.extra.chance then
				SMODS.calculate_effect({ message = {"+1 Tarot"}}, context.blueprint_card or card)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
							play_sound('timpani')
							SMODS.add_card({set = "Tarot"})
						end
						return true
					end
				}))
			end
			return nil, true
		end
	end,
}

