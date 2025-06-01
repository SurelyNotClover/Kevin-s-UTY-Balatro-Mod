
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
			mult_gain = 3,
			mult = 0
		},
	},
	loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.mult_gain, center.ability.extra.mult } }
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
	loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.xmult } }
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
	pos = {x = 2, y = 0},
	config = {
		extra = {
			chance = 3,
			mult = 10,
			chips = 80
		},
	},
	loc_vars = function(self,info_queue,center)
        return {vars = { G.GAME.probabilities.normal, center.ability.extra.chance, center.ability.extra.mult, center.ability.extra.chips } }
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

