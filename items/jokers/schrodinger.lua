local jokerInfo = {
    key = "schrodinger",
    pos = LOSTEDMOD.funcs.coordinate(13),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    config = { extra = { chips = 150, odds = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('losted_schrodinger') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                return {
                    chips = card.ability.extra.chips
                }
            else
                return {
                    message = localize('k_schrodinger_ex'),
                    colour = G.C.CHIPS
                }
            end
        end
    end
}

return jokerInfo
