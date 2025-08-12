local voucherInfo = {
    key = "negative_bias",
    pos = LOSTEDMOD.funcs.coordinate(0),
    atlas = 'losted_vouchers',
    config = { extra = { rate = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rate } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.negative_rate = card.ability.extra.rate
                return true
            end
        }))
    end
}

return voucherInfo