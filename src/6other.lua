
-- Other Characters

SMODS.Joker{
	key = 'bits_n_bites',
	loc_txt = {
		name = 'Bits & Bites',
		text = {
		'{C:attention}+#1#{} hand size while',
		'in {C:attention}Booster Pack{}'
		}
	},
	atlas = 'Other',
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	pos = {x = 0, y = 0},
	config = {
		extra = {
			hand_size = 4,
            applied = 0
		},
	},
	loc_vars = function(self,info_queue,card)
		if next(SMODS.find_card('j_sncuty_kevin')) and not card.fake_card then
			info_queue[#info_queue+1] = G.P_CENTERS.j_sncuty_irretriggerable
		end
        return {vars = { card.ability.extra.hand_size } }
	end,
    calculate = function(self, card, context)
        if context.open_booster and not (context.blueprint or context.retrigger_joker) then
            G.hand:change_size(card.ability.extra.hand_size)
			-- could've just used a bool but there's rorrim now
            card.ability.extra.applied = card.ability.extra.applied + card.ability.extra.hand_size
        end
        if (context.selling_self or context.ending_booster) and card.ability.extra.applied > 0 then
            G.hand:change_size(-card.ability.extra.hand_size)
            card.ability.extra.applied = card.ability.extra.applied - card.ability.extra.hand_size
        end
    end
}