local jd_def = JokerDisplay.Definitions -- You can assign it to a variable to use as shorthand

-- Main Characters

jd_def["j_sncuty_clover"] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return #JokerDisplay.current_hand == 1 and
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

jd_def["j_sncuty_penilla"] = {
    text = {
        { text = '+' },
        { ref_table = "card.joker_display_values", ref_value = "art" }
    },
    text_config = { colour = G.C.FILTER },
    calc_function = function(card)
        card.joker_display_values.art = #JokerDisplay.current_hand >= 5 and 1 or 0
    end
}

jd_def["j_sncuty_rorrim"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "in_blind", colour = G.C.RED },
        { text = ")" }
    },
    calc_function = function(card)
        if G.GAME.blind.in_blind then
            card.joker_display_values.in_blind = 'in blind'
        else
            card.joker_display_values.in_blind = 'not in blind'
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            if G.GAME.blind.in_blind then
                reminder_text.children[2].config.colour = G.C.RED
            else
                reminder_text.children[2].config.colour = G.C.GREEN
            end
        end
        return false
    end
}

jd_def["j_sncuty_micro_froggit"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS }
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
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xblind" }
            },
            border_colour = G.C.SECONDARY_SET.Tarot
        }
    },
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
        card.joker_display_values.active = 
        card.ability.extra.rounds_left <= 0 and "Active!" or 
        (card.ability.extra.rounds_left == 1 and card.ability.extra.rounds_left .. " round left" or 
        card.ability.extra.rounds_left .. " rounds left")
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

jd_def["j_sncuty_gerson"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "xblind" }
            },
            border_colour = G.C.SECONDARY_SET.Tarot
        }
    },
    calc_function = function(card)
        card.joker_display_values.xblind = 1 + G.GAME.next_blind_increase
    end
}

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

jd_def["j_sncuty_sandra"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "discards" },
        { text = " / " },
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "hands" },
    },
    calc_function = function(card)
        card.joker_display_values.discards = (card.ability.extra.discard_bonus and card.ability.extra.extra_discards) or 0
        card.joker_display_values.hands = (card.ability.extra.hand_bonus and card.ability.extra.extra_hands) or 0
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] and text.children[2] and text.children[4] and text.children[5] then
            text.children[1].config.colour = G.C.MULT
            text.children[2].config.colour = G.C.MULT
            text.children[4].config.colour = G.C.CHIPS
            text.children[5].config.colour = G.C.CHIPS
        end
        return false
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
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
            }
        }
    },
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

jd_def["j_sncuty_cardmaster"] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        return ((held_in_hand and held_in_hand:get_id() == 7) or (playing_card and playing_card:get_id() == 7)) and JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
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

jd_def["j_sncuty_steam_hermit"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "tarot_money"}
    },
    text_config = { colour = G.C.MONEY }
}

jd_def["j_sncuty_macro_froggit"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = "exp" }
            },
            border_colour = G.C.CHIPS
        }
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.chance } }
    end
}

jd_def["j_sncuty_giga_froggit"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            },
            border_colour = G.C.CHIPS
        }
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_mult = card.ability.extra.xchips ^ count
    end,
}

jd_def["j_sncuty_guardener"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.SECONDARY_SET.Spectral },
    reminder_text = {
        { text = "(" },
        { text = "All Suits", colour = G.C.ORANGE },
        { text = ")" }
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local suits = {
            ['Hearts'] = 0,
            ['Diamonds'] = 0,
            ['Spades'] = 0,
            ['Clubs'] = 0
        }
        if text ~= 'Unknown' then
            for i = 1, #scoring_hand do
                if scoring_hand[i].ability.name ~= 'Wild Card' then
                    if scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            for i = 1, #scoring_hand do
                if scoring_hand[i].ability.name == 'Wild Card' then
                    if scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
        end
        local is_flower_pot_hand = suits["Hearts"] > 0 and suits["Diamonds"] > 0 and suits["Spades"] > 0 and
            suits["Clubs"] > 0
            card.joker_display_values.count = is_flower_pot_hand and 1 or 0
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