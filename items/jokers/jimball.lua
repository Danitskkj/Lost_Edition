local jokerInfo = {
    key = "jimball",
    pos = LOSTEDMOD.funcs.coordinate(0),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    config = { extra = { mult_gain = 1, chips_gain = 5, mult = 0, chips = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.chips_gain, card.ability.extra.mult, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = localize('k_blind_selected_ex'),
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end
}

return jokerInfo
