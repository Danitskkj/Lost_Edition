local backInfo = {
    key = "evolutionary",
    pos = LOSTEDMOD.funcs.coordinate(0),
    atlas = 'losted_backs',
    config = {
        hand_size = -1
    },
    unlocked = false,

    loc_vars = function(self, info_queue, back)
        local growth_count = G.GAME and G.GAME.modifiers and G.GAME.modifiers.losted_evolutionary_count or 0
        local current_bonus = 1 + growth_count -- Initial + growth
        return {
            vars = {current_bonus, growth_count}
        }
    end,

    apply = function(self, back)
        -- Initialize growth counter
        G.GAME.modifiers = G.GAME.modifiers or {}
        G.GAME.modifiers.losted_evolutionary_count = G.GAME.modifiers.losted_evolutionary_count or 0
    end,

    calculate = function(self, back, context)
        -- Adjust ante to fix offset and check only on even antes (>= 4)
        local ante_check = (G.GAME.round_resets.ante )
        if context.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss and ante_check >= 4 and ante_check % 2 == 0 then

            event({
                func = function()
                    -- Increment counter
                    G.GAME.modifiers = G.GAME.modifiers or {}
                    G.GAME.modifiers.losted_evolutionary_count = (G.GAME.modifiers.losted_evolutionary_count or 0) + 1

                    -- Increase hand size
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
