local jokerInfo = {
    key = "fair_price",
    pos = LOSTEDMOD.funcs.coordinate(54),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = false,
    config = { extra = { xmult = 3, dollar_cost = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.dollar_cost } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            local current_money = G.GAME.dollars or 0
            if to_big(current_money) >= to_big(card.ability.extra.dollar_cost) then
                ease_dollars(-card.ability.extra.dollar_cost)
                card_eval_status_text(card, 'dollars', -card.ability.extra.dollar_cost)
            else
                LOSTEDMOD.funcs.destroy_joker(card)
                return {
                    message = localize('k_extinct_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
}

return jokerInfo
