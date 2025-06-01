SMODS.Atlas{
	key = 'uty_Partner',
	path = 'Partners.png',
	px = 46,
	py = 58
}

Partner_API.Partner{
    key = "gunhat",
    name = 'Gun Hat Partner',
    loc_txt = {
        name = "Gun Hat",
        text = {
            'If played hand contains',
            'only {C:attention}1{} card',
            'that card gives {X:mult,C:white}X#1#{} Mult'
        }
    },
    unlocked = true,
    discovered = true,
    no_quips = true,
    pos = {x = 0, y = 0},
    atlas = "uty_Partner",
    config = {
        extra = {
            related_card = "j_sncuty_clover",
            xmult = 1.5
        }
    },
    loc_vars = function(self, info_queue, card)
        if next(SMODS.find_card("j_sncuty_clover")) then card.ability.extra.xmult = 2 else card.ability.extra.xmult = 1.5 end
        return { vars = {card.ability.extra.xmult} }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.full_hand and #context.full_hand == 1 then
            if next(SMODS.find_card("j_sncuty_clover")) then card.ability.extra.xmult = 2 else card.ability.extra.xmult = 1.5 end
            return {
                xmult = card.ability.extra.xmult,
                card = card
            }
        end
    end,
}

Partner_API.Partner{
    key = "crusty",
    name = 'Crusty Partner',
    loc_txt = {
        name = "Crusty",
        text = {
            'Creates #1# {C:tarot}Tarot{} card(s)',
            'if played hand sets',
            'the {C:attention}Score{} on {C:mult}Fire{}'
        }
    },
    unlocked = true,
    discovered = true,
    no_quips = true,
    pos = {x = 1, y = 0},
    atlas = "uty_Partner",
    config = {
        extra = {
            related_card = "j_sncuty_crispy_scroll",
        }
    },
    loc_vars = function(self, info_queue, card)
        local benefits = false
        if next(SMODS.find_card("j_sncuty_crispy_scroll")) then benefits = true end
        return { vars = {(benefits and 2) or 1} }
    end,
    calculate = function(self, card, context)
        
        if context.partner_main and G.GAME.blind and (hand_chips * mult >= G.GAME.blind.chips) then
            local benefits = false
            if next(SMODS.find_card("j_sncuty_crispy_scroll")) then benefits = true end
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({set = "Tarot"})
                    if benefits then
                        SMODS.add_card({set = "Tarot"})
                    end
                    return true
                end
            }))
            return {
                message = "RAAAHH!",
                colour = G.C.RED
            }
        end
    end,
}

Partner_API.Partner{
    key = "money",
    name = 'Money Partner',
    loc_txt = {
        name = "Money",
        text = {
            'Click to spend {C:money}$#1#{}',
            'to create {C:tarot}Tarot{}',
            'or {C:planet}Planet{} card'
        }
    },
    unlocked = true,
    discovered = true,
    no_quips = true,
    pos = {x = 2, y = 0},
    atlas = "uty_Partner",
    config = {
        extra = {
            related_card = "j_sncuty_mostand",
            cost = 4
        }
    },
    loc_vars = function(self, info_queue, card)
        if next(SMODS.find_card("j_sncuty_mostand")) then card.ability.extra.cost = 3 else card.ability.extra.cost = 4 end
        return { vars = {card.ability.extra.cost} }
    end,
    calculate = function(self, card, context)
        if context.partner_click then
            if next(SMODS.find_card("j_sncuty_mostand")) then card.ability.extra.cost = 3 else card.ability.extra.cost = 4 end
            if ((to_big(G.GAME.dollars) - to_big(G.GAME.bankrupt_at)) >= to_big(card.ability.extra.cost)) then
                G.GAME.partner_click_deal = true
                if pseudorandom("money_card") < 1/2 then
                    SMODS.add_card({set = "Tarot"})
                else
                    SMODS.add_card({set = "Planet"})
                end
                ease_dollars(-card.ability.extra.cost)
                card_eval_status_text(card, "dollars", -card.ability.extra.cost)
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.partner_click_deal = nil
                return true end}))
            end
        end
    end,
}

Partner_API.Partner{
    key = "mel",
    name = 'Mel Partner',
    loc_txt = {
        name = "Mel",
        text = {
            'Earn extra {C:money}$#1#{} when',
            '{C:attention}selling{} cards'
        }
    },
    unlocked = true,
    discovered = true,
    no_quips = true,
    pos = {x = 3, y = 0},
    atlas = "uty_Partner",
    config = {
        extra = {
            related_card = "j_sncuty_honeydew",
            dollar = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        local benefits = 1
        if next(SMODS.find_card("j_sncuty_honeydew")) then benefits = 2 end
        return { vars = {card.ability.extra.dollar*benefits} }
    end,
    calculate = function(self, card, context)
        if context.partner_selling_card then
            local benefits = 1
            if next(SMODS.find_card("j_sncuty_honeydew")) then benefits = 2 end
            return {
                dollars = card.ability.extra.dollar*benefits
            }
        end
    end,
}

--[[

m - finish me.
k - later.

Partner_API.Partner{
    key = "mooch",
    name = 'Mooch Partner',
    loc_txt = {
        name = "Sneaky",
        text = {
            '#1# card(s) after the first',
            'reroll in the {C:attention}shop{} is {C:attention}free'
        }
    },
    unlocked = true,
    discovered = true,
    no_quips = true,
    pos = {x = 1, y = 0},
    atlas = "uty_Partner",
    config = {
        extra = {
            related_card = "j_sncuty_mooch",
            free_card = 1,
            its_free = true
        }
    },
    loc_vars = function(self, info_queue, card)
        if next(SMODS.find_card("j_sncuty_mooch")) then card.ability.extra.free_card = 2 else card.ability.extra.free_card = 1 end
        return { vars = {benefits}}
    end,
    calculate = function(self, card, context)
        if context.partner_reroll_shop and card.ability.extra.its_free then
            for i = 1, #G.shop_jokers.cards do
                G.shop_jokers.cards[i].ability.couponed = true; G.shop_jokers.cards[i]:set_cost()
            end
        end
        if context.buying_card then
            card
        end
    end,
}]]

Partner_API.Partner{
    key = "kevin",
    name = 'Kevin Partner',
    loc_txt = {
        name = "Kevin",
        text = {
            'Retrigger {C:attention}last{} scoring card',
            '{C:attention}#1#{} additional time(s) for every',
            "{C:money}Kevin's UTY {C:attention}Joker{} owned"
        }
    },
    unlocked = true,
    discovered = true,
    no_quips = true,
    pos = {x = 4, y = 0},
    atlas = "uty_Partner",
    config = {
        extra = {
            related_card = "j_sncuty_kevin",
            repetition = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        local benefits = 1
        if next(SMODS.find_card("j_sncuty_kevin")) then benefits = 2 end
        return { vars = {card.ability.extra.repetition*benefits} }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.other_card and context.scoring_hand and context.other_card == context.scoring_hand[#context.scoring_hand] then
            local benefits = 1
            if next(SMODS.find_card("j_sncuty_kevin")) then benefits = 2 end
            local jokers = {}
            for k, v in pairs(G.jokers.cards) do
                if string.find(v.config.center.key, "j_sncuty_") then
                    table.insert(jokers, v)
                end
            end
            if card.ability.extra.repetition*benefits*#jokers > 0 then
                return {
                    repetitions = card.ability.extra.repetition*benefits*#jokers,
                    card = card
                }
            end
        end
    end,
}