local jokerInfo = {
    key = "vandalism",
    pos = LOSTEDMOD.funcs.coordinate(56),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = false,
    config = { extra = { percent = 30 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.percent } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            -- Check if already processed by another Vandalism
            if G.GAME.vandalism_processed then
                return nil
            end
            
            -- Count how many Vandalism jokers exist
            local vandalism_count = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config and joker.config.center and joker.config.center.key == 'j_losted_vandalism' then
                    vandalism_count = vandalism_count + 1
                end
            end
            
            -- Mark as processed to prevent multiple executions
            G.GAME.vandalism_processed = true
            
            local total_percent_reduction = card.ability.extra.percent * vandalism_count
            local final_chips = math.floor(G.GAME.blind.chips * (100 - total_percent_reduction) / 100)
            local chip_diff = G.GAME.blind.chips - final_chips
            local chip_mod = math.ceil(chip_diff / 120)
            local step = 0
            
            G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
                if G.GAME.blind.chips > final_chips then
                    G.GAME.blind.chips = G.GAME.blind.chips - G.SETTINGS.GAMESPEED * chip_mod
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    if step % 5 == 0 then
                        play_sound('chips1', math.max(1.0 - (step * 0.005), 0.001))
                    end
                    step = step + 1
                else
                    G.GAME.blind.chips = final_chips
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    -- Clear flag when animation ends
                    G.GAME.vandalism_processed = nil
                    return true
                end
            end}))
            
            return {
                message = localize('k_vandalism_ex'),
                colour = G.C.RED
            }
        end
        return nil
    end
}

return jokerInfo