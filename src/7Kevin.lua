SMODS.Atlas{
	key = 'Kevin',
	path = '7Kevin.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = 'kevin',
	loc_txt = {
		name = 'Kevin',
		text = {
		'Retrigger all',
		"{C:money}Kevin's UTY{} Jokers"
		}
	},
	atlas = 'Kevin',
	rarity = 4,
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {x = 0, y = 0},
	soul_pos = { x = 1, y = 0 },
	config = {
		extra={
			repetitions = 1,
			frame = 0
		},
	},
	loc_vars = function(self,info_queue,center)
        return {vars = { } }
	end,

	update = function(self, card, dt)
		card.ability.extra.frame = card.ability.extra.frame + dt
		card.children.floating_sprite:set_sprite_pos({x = 1 + math.floor(card.ability.extra.frame), y = 0})
		if card.ability.extra.frame > 7 then
			card.ability.extra.frame = 0
		end
	end,

	calculate = function(self, card, context)
		
		if context.retrigger_joker_check and not context.retrigger_joker and not context.blueprint
		and string.find(context.other_card.config.center.key, "j_sncuty_") 
		and not string.find(context.other_card.config.center.key, "blackjack")
		and not string.find(context.other_card.config.center.key, "martlet")
		and not string.find(context.other_card.config.center.key, "chujin")
		and not string.find(context.other_card.config.center.key, "mostand")
		and not string.find(context.other_card.config.center.key, "bits_n_bites") then
			if context.other_card.config.center.key ~= "j_sncuty_honeydew" then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = card,
				}
			else
				return {
					message = 'Hey~',
					repetitions = card.ability.extra.repetitions*2,
					card = card,
				}
			end
		end
	end
}

SMODS.Challenge({
	key = "date_night",
	loc_txt = { name = 'Date Night' },
	rules = {
		custom = {
			{id = 'no_shop_jokers'},
			{id = 'no_planets'},
		},
		modifiers = {
            { id = 'joker_slots', value = 2 }
		}
	},
	jokers = {
		{id = 'j_sncuty_kevin', eternal = true},
		{id = 'j_sncuty_honeydew', eternal = true}
	},
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			{id = 'c_judgement'},
            {id = 'c_wraith'},
            {id = 'c_soul'},
			{id = 'c_ectoplasm'},
			{id = 'c_ankh'},
			{id = 'c_hex'},
			{id = 'v_blank'},
            {id = 'v_antimatter'},
            {id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
            }},
			{id = 'p_celestial_normal_1', ids = {
                'p_celestial_normal_1','p_celestial_normal_2','p_celestial_normal_3','p_celestial_normal_4','p_celestial_jumbo_1','p_celestial_jumbo_2','p_celestial_mega_1','p_celestial_mega_2',
            }},
		},
		banned_tags = {
			{id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_holo'},
            {id = 'tag_polychrome'},
            {id = 'tag_negative'},
            {id = 'tag_foil'},
            {id = 'tag_buffoon'},
			{id = 'tag_meteor'},
            {id = 'tag_top_up'},
		},
		banned_other = {
			{id = 'bl_final_acorn', type = 'blind'},
			{id = 'bl_final_heart', type = 'blind'},
			{id = 'bl_final_leaf', type = 'blind'}
		},
	},
})