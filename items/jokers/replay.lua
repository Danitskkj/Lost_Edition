local jokerInfo = {
    key = "replay",
    pos = LOSTEDMOD.funcs.coordinate(11),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    config = { 
        extra = { 
            repetitions = 2 
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[#context.scoring_hand] then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}

return jokerInfo