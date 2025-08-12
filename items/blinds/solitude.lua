local blindInfo = {
    key = 'solitude',
    pos = { x = 0, y = 9 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 4 },
    boss_colour = HEX('d354f2'),
    recalc_debuff = function(self, card, from_blind)
        if card.area ~= G.jokers and not G.GAME.blind.disabled then
            local v = card.base.value
            if v == "3" or v == "5" or v == "7" or v == "9" or v == "Ace" then
                return true
            end
        end
        return false
    end
}

return blindInfo