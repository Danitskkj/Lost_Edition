local backInfo = {
    key = "evolutionary",
    pos = LOSTEDMOD.funcs.coordinate(0),
    atlas = 'losted_backs',
    unlocked = false,
    calculate = function(self, back, context)
        local ante_check = (G.GAME.round_resets.ante )
        if context.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss and ante_check >= 4 and ante_check % 2 == 0 then
            event({
                func = function()
                    G.hand:change_size(1)
                    return true
                end
            })
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 12 } }
    end,
    check_for_unlock = function(self, args)
        return G.hand and G.hand.config.card_limit >= 12
    end
}

return backInfo
