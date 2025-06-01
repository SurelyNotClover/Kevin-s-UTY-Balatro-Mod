local jd_def = JokerDisplay.Definitions -- You can assign it to a variable to use as shorthand

-- Main Characters

jd_def["j_sncuty_clover"] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return #scoring_hand == 1 and
            joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}

jd_def["j_sncuty_flowey"] = {

}

jd_def["j_sncuty_ceroba"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult" }
            }
        }
    },
}

jd_def["j_sncuty_chujin"] = {
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "rounds_played" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "round_req" },
        { text = ")" }
    },
    text_config = { colour = G.C.UI.TEXT_INACTIVE },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.active = (G.GAME and card.ability.extra.rounds_played == card.ability.extra.round_req and card.ability.extra.new_round == 1 and G.GAME.current_round.hands_left == 1 and localize("jdis_active") or localize("jdis_inactive"))
    end
}

-- Ruins Characters

jd_def["j_sncuty_pops"] = {
    -- TODO
}

-- Snowdin Characters

jd_def["j_sncuty_slurpy"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "sells_left" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "sell_req" },
        { text = ")" },
    },
}

jd_def["j_sncuty_honeydew_coffee"] = {
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "unscores_left" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "unscore_req" },
        { text = ")" },
    },
    text_config = { colour = G.C.UI.TEXT_INACTIVE }
}

jd_def["j_sncuty_soggy_mitten"] = {
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "rerolls_left" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "reroll_req" },
        { text = ")" },
    },
    text_config = { colour = G.C.UI.TEXT_INACTIVE }
}

jd_def["j_sncuty_snowdin_map"] = {
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "destroys_left" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "destroy_req" },
        { text = ")" },
    },
    text_config = { colour = G.C.UI.TEXT_INACTIVE }
}

jd_def["j_sncuty_matches"] = {
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "plays_left" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "play_req" },
        { text = ")" },
    },
    text_config = { colour = G.C.UI.TEXT_INACTIVE }
}

jd_def["j_sncuty_lakewarm_coffee"] = {
    
}

jd_def["j_sncuty_silver_scarf"] = {
    
}

jd_def["j_sncuty_mo"] = {
    text = {
        { text = "-$" },
        { ref_table = "card.ability.extra", ref_value = "money_loss" },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        if card.ability.extra.rounds_left == 1 then
            card.joker_display_values.active = card.ability.extra.rounds_left <= 0 and
            localize("k_active") or
            (card.ability.extra.rounds_left .. " round left")
        else
            card.joker_display_values.active = card.ability.extra.rounds_left <= 0 and
            localize("k_active") or
            (card.ability.extra.rounds_left .. " rounds left")
        end
    end
}

jd_def["j_sncuty_mostand"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "money_gain" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}

jd_def["j_sncuty_trihecta"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS }
}

jd_def["j_sncuty_shufflers"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.chance } }
    end
    
}

jd_def["j_sncuty_flame_guy"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "money"}
    },
    text_config = { colour = G.C.MONEY }
}

jd_def["j_sncuty_honeydew"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}

-- Dunes Characters

jd_def["j_sncuty_tnt_man"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        card.joker_display_values.x_mult = G.GAME and G.GAME.current_round.hands_left <= 1 and card.ability.extra.xmult or 1
    end
}

jd_def["j_sncuty_matt_miner"] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return playing_card.config.center == G.P_CENTERS.m_stone and
            joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}

jd_def["j_sncuty_tall_miner"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "money"}
    },
    text_config = { colour = G.C.MONEY },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.chance } }
    end
}


jd_def["j_sncuty_snake_miner"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = (G.GAME and G.GAME.current_round.hands_played == 0 and localize("jdis_active") or localize("jdis_inactive"))
    end
}

jd_def["j_sncuty_stresso_miner"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card.config.center == G.P_CENTERS.m_stone then
                    mult = mult +
                        card.ability.extra.mult *
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.mult = mult
    end
}

jd_def["j_sncuty_gilbert"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "stones_selected" }
    },
    text_config = { colour = G.C.UI.TEXT_INACTIVE },
    reminder_text = {
        { text = "(" },
        { ref_table = "G.hand.config", ref_value = "highlighted_limit" },
        { text = " card limit)" }
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if SMODS.has_enhancement(scoring_card, "m_stone") then
                    count = count + 1
                end
            end
        end
        if count == 1 then
            card.joker_display_values.stones_selected = count .. ' Stone'
        else
            card.joker_display_values.stones_selected = count .. ' Stones'
        end
    end
}

jd_def["j_sncuty_gamer"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "money" }
    },
    text_config = { colour = G.C.MONEY },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "rank_text" },
        { text = "+" },
        { text = "Three of a Kind" },
        { text = ")" }
    },
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] and reminder_text.children[4] then
            reminder_text.children[2].config.colour = G.C.FILTER
            reminder_text.children[4].config.colour = G.C.FILTER
        end
        return false
    end
}

jd_def["j_sncuty_rosa"] = {
    extra = {
        {
            { text = "(", scale = 0.2 },
            { border_nodes = {
                { text = "X", scale = 0.2 },
                { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp", scale = 0.2 }
            } },
            { text = ")", scale = 0.2 },
        }
    },
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x", scale = 0.35 },
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit" },
        { text = ")" }
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit("Hearts") or scoring_card.ability.name == 'Wild Card' then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.xmult = card.ability.extra.xmult ^ count
        card.joker_display_values.suit = "Hearts"
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS.Hearts, 0.35)
        end
        if extra and extra.children[2] then
            extra.children[2].config.colour = lighten(G.C.SUITS.Hearts, 0.35)
        end
        return false
    end
}

jd_def["j_sncuty_pedla"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.SECONDARY_SET.Tarot },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit" },
        { text = ")" }
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit("Diamonds") or scoring_card.ability.name == "Wild Card" then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.tarot_chance } }
        card.joker_display_values.suit = "Diamonds"
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS.Diamonds, 0.35)
        end
        return false
    end
}

jd_def["j_sncuty_violleta"] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return ((playing_card:is_suit("Spades") or playing_card:is_suit("Clubs") or playing_card.ability.name == "Wild Card") and playing_card.config.center ~= G.P_CENTERS.c_base) and
            joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}

jd_def["j_sncuty_fortune_teller"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "odds" },
    },
    text_config = { colour = G.C.GREEN },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "active_text" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.copy_chance } }
    end
}

jd_def["j_sncuty_corn_chowder"] = {
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "rounds" },
        { text = ")" },
    },
    text_config = { colour = G.C.UI.TEXT_INACTIVE },
    calc_function = function(card)
        if card.ability.extra.rounds_played == 1 then
            card.joker_display_values.rounds = card.ability.extra.rounds_played .. " round"
        else
            card.joker_display_values.rounds = card.ability.extra.rounds_played .. " rounds"
        end
    end
}

jd_def["j_sncuty_ace"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
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
        card.joker_display_values.xmult = card.ability.extra.xmult + (#aces * card.ability.extra.xmult_ace)
    end
}

jd_def["j_sncuty_ed"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult" }
            }
        }
    },
}

jd_def["j_sncuty_blackjack"] = {
    text = {
        { text = "-$" },
        { ref_table = "card.ability.extra", ref_value = "money_loss" },
    },
    text_config = { colour = G.C.RED },
    extra = {
        {
            { text = "+" },
            { ref_table = "card.ability.extra", ref_value = "hand_gain" },
            { text = " Hands" }
        }
    },
    extra_config = { colour = G.C.BLUE },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = (card.ability.extra.hands_played >= 1 and localize("jdis_active") or localize("jdis_inactive"))
    end
}

-- Steamworks Characters

jd_def["j_sncuty_jandroid"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "xmult" }
            }
        }
    },
    calc_function = function(card)
        local score = true
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card.config.center == G.P_CENTERS.c_base then
                    score = false
                end
            end
        end
        card.joker_display_values.xmult = ((#G.hand.highlighted > 0 or #G.play.cards > 0) and score and card.ability.extra.xmult) or 1
    end
}


jd_def["j_sncuty_lil_bots"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult" },
        { text = " +" },
        { ref_table = "card.ability.extra", ref_value = "chips" },
    },
    reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.chance } }
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] and text.children[2] and text.children[3] and text.children[4] then
            text.children[1].config.colour = G.C.MULT
            text.children[2].config.colour = G.C.MULT
            text.children[3].config.colour = G.C.CHIPS
            text.children[4].config.colour = G.C.CHIPS
        end
        return false
    end
}

jd_def["j_sncuty_manta_bot"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult" }
    },
    text_config = { colour = G.C.MULT }
}