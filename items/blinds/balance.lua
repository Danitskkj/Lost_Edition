local blindInfo = {
    key = 'balance',
    pos = { x = 0, y = 8 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 4 },
    boss_colour = HEX('477de3'),
    recalc_debuff = function(self, card, from_blind)
        if card.area ~= G.jokers and not G.GAME.blind.disabled then
            local v = card.base.value
            if v == "2" or v == "4" or v == "6" or v == "8" or v == "10" then
                return true
            end
        end
        return false
    end
}

return blindInfo