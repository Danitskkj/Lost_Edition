local backInfo = {
    key = "fortune",
    pos = LOSTEDMOD.funcs.coordinate(1),
    atlas = 'losted_backs',
    unlocked = true,
    apply = function(self)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * 2
        end
    end,
}

return backInfo
