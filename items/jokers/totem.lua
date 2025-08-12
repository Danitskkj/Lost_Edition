-- Dollar bonus system for Totem
if not LOSTEDMOD.totem_bonus then
    LOSTEDMOD.totem_bonus = true

    -- 1 in 3 chance to double the money gained (100% bonus)
    local function bonus_dollars_if_totem(mod)
        if tonumber(mod) > tonumber(0) and G.jokers then
            for _, v in ipairs(G.jokers.cards) do
                if v.config and v.config.center and v.config.center.key == 'j_losted_totem' and not v.debuff then
                    local odds = (v.config.extra and v.config.extra.odds) or 3
                    if pseudorandom('losted_totem') < (G.GAME.probabilities.normal or 1) / odds then
                        local bonus = tonumber(mod) -- 100% bonus
                        local total = tonumber(mod) + bonus
                        G.E_MANAGER:add_event(Event {
                            func = function()
                                card_eval_status_text(v, 'extra', nil, nil, nil, {
                                    message = '$' .. tostring(bonus),
                                    colour = G.C.MONEY,
                                    instant = true
                                })
                                return true
                            end
                        })
                        return total
                    end
                end
            end
        end
        return mod
    end

    -- Hook to add bonus money if Totem is present
    local original_ease_dollars = ease_dollars
    function ease_dollars(mod, ...)
        mod = bonus_dollars_if_totem(mod)
        return original_ease_dollars(mod, ...)
    end
end

local jokerInfo = {
    key = "totem",
    pos = LOSTEDMOD.funcs.coordinate(26),
    atlas = 'losted_jokers',
    rarity = 3,
    cost = 8,
    unlocked = false,
    blueprint_compat = true,
    config = {
        extra = {
            odds = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds}
        }
    end,
    calculate = function(self, card, context)
        return nil
    end,
    in_pool = function(self)
        return true
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win_challenge' and G.GAME.challenge == 'c_losted_running_on_fumes' then
            self.challenge_bypass = true
            unlock_card(self)
        end
    end,
}

return jokerInfo
