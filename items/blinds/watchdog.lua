local blindInfo = {
    key = 'watchdog',
    pos = { x = 0, y = 6 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 2 },
    boss_colour = HEX('e0e2e3'),
    config = {},

    defeat = function(self)
        if not G.GAME.blind.disabled then
            G.GAME.watchdog_flag = true
        end
    end,

}

return blindInfo