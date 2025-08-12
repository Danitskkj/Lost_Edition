local jokerInfo = {
    key = "toc_toc",
    pos = LOSTEDMOD.funcs.coordinate(22),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before then
            local dollars = G.GAME.current_round.discards_left or 0
            if dollars > 0 then
                return { dollars = dollars }
            end
        end
    end
}

return jokerInfo