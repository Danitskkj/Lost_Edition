local voucherInfo = {
    key = "extra_bag",
    pos = LOSTEDMOD.funcs.coordinate(2),
    atlas = 'losted_vouchers',
    redeem = function(self)
        G.GAME.modifiers.extra_boosters = (G.GAME.modifiers.extra_boosters or 0) + 1
        SMODS.add_booster_to_shop()
    end
}

return voucherInfo
