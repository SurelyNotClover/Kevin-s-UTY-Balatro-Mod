SMODS.Challenge({
	key = "joker_juggle",
	loc_txt = { name = 'Joker Juggle' },
	rules = {
		custom = {
            { id = 'no_shop_jokers' }
		},
		modifiers = {
            { id = 'joker_slots', value = 6 }
		}
	},
	jokers = {
		{id = 'j_sncuty_silver_scarf', eternal = true},
		{id = 'j_sncuty_flowey', eternal = true},
		{id = 'j_riff_raff', eternal = true}
	},
    consumeables = {
		
    },
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			{id = 'c_judgement'},
			{id = 'c_wraith'},
			{id = 'c_soul'},
			{id = 'c_ankh'},
			{id = 'v_blank'},
			{id = 'v_antimatter'},
			{id = 'p_buffoon_normal_1', ids = {
				'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
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
			{id = 'tag_top_up'},

		},
		banned_other = {
			{id = 'bl_final_acorn', type = 'blind'},
			{id = 'bl_final_heart', type = 'blind'},
			{id = 'bl_final_leaf', type = 'blind'}
		}
	},
})

SMODS.Challenge({
	key = "woodworking",
	loc_txt = { name = 'Woodworking' },
	rules = {
		custom = {
			{ id = 'no_shop_jokers' },
			{ id = 'no_shop_planets' }
		},
		modifiers = {
			{ id = 'joker_slots', value = 1 }
		}
	},
	jokers = {
		{id = 'j_sncuty_martlet', eternal = true}
	},
    consumeables = {

    },
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			{id = 'c_judgement'},
			{id = 'c_wraith'},
			{id = 'c_soul'},
			{id = 'c_high_priestess'},
			{id = 'c_wheel_of_fortune'},
			{id = 'c_ankh'},
			{id = 'c_hex'},
			{id = 'c_ectoplasm'},
			{id = 'v_blank'},
			{id = 'v_antimatter'},
			{id = 'p_buffoon_normal_1', ids = {
				'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
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
			{id = 'tag_top_up'},

		},
		banned_other = {
			{id = 'bl_final_acorn', type = 'blind'},
			{id = 'bl_final_heart', type = 'blind'},
			{id = 'bl_final_leaf', type = 'blind'}
		}
	},
})

SMODS.Challenge({
	key = "wild_fire",
	loc_txt = { name = 'Wild Fire' },
	rules = {
		custom = {
            
		},
		modifiers = {
			{ id = 'dollars', value = 14 },
			{ id = 'hands', value = 1 },
			{ id = 'discards', value = 4 }
		}
	},
	jokers = {
		{id = 'j_sncuty_ceroba', eternal = true}
	},
    consumeables = {

    },
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			{ id = 'j_burglar' },
			{ id = 'j_troubadour' },
			{ id = 'v_grabber' },
			{ id = 'v_nacho_tong' }
		},
		banned_tags = {
			
		},
		banned_other = {

		},
	},
})

SMODS.Challenge({
	key = "wardrobe",
	loc_txt = { name = 'Wardrobe' },
	rules = {
		custom = {
            { id = 'no_flush' }
		},
		modifiers = {
            { id = 'joker_slots', value = 4 }
		}
	},
	jokers = {
		{id = 'j_sncuty_pops', eternal = true},
	},
    consumeables = {
        {id = 'c_world'},
        {id = 'c_world', edition = 'negative'},
        {id = 'c_sun', edition = 'negative'},
        {id = 'c_sun'},
    },
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			{id = 'j_droll'},
			{id = 'j_crafty'},
			{id = 'j_tribe'},
			{id = 'c_jupiter'},
			{id = 'c_neptune'},
			{id = 'c_ceres'},
			{id = 'c_eris'},
		},
		banned_tags = {
			
		},
		banned_other = {

		},
	},
})

SMODS.Challenge({
	key = "sandstorm",
	loc_txt = { name = 'Sandstorm' },
	rules = {
		custom = {
            
		},
		modifiers = {
			
		}
	},
	jokers = {
		{id = 'j_marble', eternal = true, edition = 'negative'},
		{id = 'j_sncuty_dunebud', eternal = true}
	},
    consumeables = {

    },
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			
		},
		banned_tags = {
			
		},
		banned_other = {
			{id = 'bl_eye', type = 'blind'},
		},
	},
})

SMODS.Challenge({
	key = "mining_operation",
	loc_txt = { name = 'Mining Operation' },
	rules = {
		custom = {
            {id = 'joker_slots', value = 6}
		},
		modifiers = {
			
		}
	},
	jokers = {
		{id = 'j_sncuty_stresso_miner', eternal = true},
		{id = 'j_sncuty_matt_miner', eternal = true},
		{id = 'j_sncuty_tall_miner', eternal = true},
		{id = 'j_sncuty_snake_miner', eternal = true},
	},
    consumeables = {
        {id = 'c_tower'},
        {id = 'c_tower'},
        {id = 'c_tower'},
    },
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			
		},
		banned_tags = {
			
		},
		banned_other = {
			{id = 'bl_eye', type = 'blind'},
		},
	},
})

SMODS.Challenge({
	key = "shopping_spree",
	loc_txt = { name = 'Shopping Spree' },
	rules = {
		custom = {
            { id = 'no_shop_items' },
		},
		modifiers = {
            { id = 'joker_slots', value = 9 },
            { id = 'dollars', value = 9 }
		}
	},
	jokers = {
		{id = 'j_sncuty_giftshopper', eternal = true},
		{id = 'j_sncuty_giftshopper', eternal = true},
		{id = 'j_sncuty_giftshopper', eternal = true},
		{id = 'j_sncuty_byte', eternal = true},
	},
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			{id = 'v_overstock_norm'},
			{id = 'v_overstock_plus'},
			{id = 'v_reroll_surplus'},
			{id = 'v_reroll_glut'},
			{id = 'v_tarot_merchant'},
			{id = 'v_tarot_tycoon'},
			{id = 'v_planet_merchant'},
			{id = 'v_planet_tycoon'},
			{id = 'v_magic_trick'},
			{id = 'v_illusion'},
		},
		banned_tags = {
			{id = 'tag_uncommon'},
            {id = 'tag_rare'},
            {id = 'tag_negavive'},
            {id = 'tag_foil'},
            {id = 'tag_holo'},
            {id = 'tag_polychrome'},
            {id = 'tag_top_up'},
            {id = 'tag_d_six'},
		},
		banned_other = {

		},
	},
})

local onlyClubs = {}
for i, k in pairs(G.P_CARDS) do
	local card_id_parts = {}
	for part in string.gmatch(i, "([^_]+)") do
		table.insert(card_id_parts, part)
	end
	table.insert(onlyClubs,{ s = "C" , r = card_id_parts[2] })
end

SMODS.Challenge({
	key = "gardening",
	loc_txt = { name = 'Gardening' },
	rules = {
		custom = {
            
		},
		modifiers = {
			
		}
	},
	jokers = {
		{id = 'j_sncuty_rosa', eternal = true},
		{id = 'j_sncuty_pedla', eternal = true},
		{id = 'j_sncuty_violleta', eternal = true},
	},
    consumeables = {
        {id = 'c_lovers'},
        {id = 'c_lovers'},
        {id = 'c_lovers'},
    },
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			
		},
		banned_tags = {
			
		},
		banned_other = {

		},
	},
})

SMODS.Challenge({
	key = "lava_run",
	loc_txt = { name = 'Lava Run' },
	rules = {
		custom = {
            
		},
		modifiers = {
			
		}
	},
	jokers = {
		{id = 'j_runner', eternal = true},
		{id = 'j_sncuty_manta_bot', eternal = true}
	},
    consumeables = {
		
    },
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			
		},
		banned_tags = {
			
		},
		banned_other = {

		},
	},
})

function SMODS.current_mod.process_loc_text()
    G.localization.misc.v_text.ch_c_no_flush = {"Hands containing {C:attention}Flush{} will not score"}
	G.localization.misc.v_text.ch_c_no_shop_items = {"Only {C:attention}Vouchers{} and {C:attention}Booster Packs{} will appear in the {C:attention}Shop{}"}
	G.localization.misc.v_text.ch_c_no_shop_planets = {"Planet Cards only appear in {C:attention}Booster Packs{}"}
	G.localization.misc.v_text.ch_c_no_planets = {"Planet Cards no longer appear in the {C:attention}shop{}"}
end

local gfcr = G.FUNCS.can_reroll
function G.FUNCS.can_reroll(e)
	if G.GAME.modifiers.no_shop_items then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		return gfcr(e)
	end
end

local ch_start_challenge = Game.start_run
function Game:start_run(args)
    ch_start_challenge(self, args)

    if G.GAME.modifiers.no_shop_items then
		change_shop_size(-2)
	end

	if G.GAME.modifiers.no_planets or G.GAME.modifiers.no_shop_planets then
		G.GAME.planet_rate = 0
	end
end

local ch_debuff = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
	if G.GAME.modifiers.no_flush then
    	if string.find(handname, "Flush") then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end
	return ch_debuff(self, cards, hand, handname, check)
end