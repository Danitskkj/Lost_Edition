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
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_losted_diamond' },
                colours = { get_stake_col(9) }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 9
    end
}

return backInfo
