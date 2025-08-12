local voucherInfo = {
    key = "staple_gun",
    pos = LOSTEDMOD.funcs.coordinate(11), 
    atlas = 'losted_vouchers',
    config = {},
    unlocked = false,
    requires = { 'v_losted_stapler' },
    redeem = function(self, card)
        G.GAME.losted_staple_gun_active = true
    end,
    load = function(self, card, card_table, other_card)
        G.GAME.losted_staple_gun_active = true
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 50, G.PROFILES[G.SETTINGS.profile].career_stats.c_jokers_bought } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'career_stat' and args.statname == 'c_jokers_bought' then
            return G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 50
        end
        return false
    end
}

return voucherInfo