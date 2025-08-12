local blindInfo = {
    key = 'privilege',
    pos = { x = 0, y = 2 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 4 },
    boss_colour = HEX('ffdf7d'),
    config = {},
    loc_vars = function(self)
        return { vars = { G.GAME.probabilities.normal or 1} }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1' } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and
                pseudorandom('losted_privilege') < G.GAME.probabilities.normal / 8 then
                return {
                    debuff = true
                }
            end
        end
    end,
}

return blindInfo