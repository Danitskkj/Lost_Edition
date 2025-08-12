local backInfo = {
    key = "medieval",
    pos = LOSTEDMOD.funcs.coordinate(3),
    atlas = 'losted_backs',
    unlocked = false,
    discovered = true,
    config = { joker_slot = 2 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.joker_slot }}
    end,

    calculate = function(self, back, context)
        if G.GAME.round_resets.ante >= 2 then
            G.GAME.modifiers.boss_rush = true
        else
            G.GAME.modifiers.boss_rush = false
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win_challenge' and G.GAME.challenge == 'c_losted_medieval_era' then
            self.challenge_bypass = true
            unlock_card(self)
        end
    end,
}

return backInfo