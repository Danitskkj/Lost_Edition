local jokerInfo = {
    key = "rule_book",
    pos = LOSTEDMOD.funcs.coordinate(21),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    blueprint_compat = true, 
    config = {
        extra = {
            xmult = 1.5
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.xmult
        } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            local is_last = context.scoring_hand[#context.scoring_hand] == context.other_card
            if is_last then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

return jokerInfo