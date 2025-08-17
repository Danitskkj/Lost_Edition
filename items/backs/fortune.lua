local backInfo = {
    key = "fortune",
    pos = LOSTEDMOD.funcs.coordinate(1),
    atlas = 'losted_backs',
    unlocked = false,
    apply = function(self)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * 2
        end
    end,
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_plasma'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_plasma' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_plasma') > 0
    end
}

return backInfo
