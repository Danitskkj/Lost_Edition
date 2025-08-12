local voucherInfo = {
    key = "booster_bag",
    pos = LOSTEDMOD.funcs.coordinate(12),
    atlas = 'losted_vouchers',
    config = { unlock = 25 },
    requires = {"v_losted_extra_bag"},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {vars = {self.config.unlock, G.PROFILES[G.SETTINGS.profile].booster_packs_opened or 0}}
    end,
    check_for_unlock = function(self, args)
        if args.type == 'open_pack' and args.packs_total >= self.config.unlock then
            unlock_card(self)
        end
    end,

}

return voucherInfo
