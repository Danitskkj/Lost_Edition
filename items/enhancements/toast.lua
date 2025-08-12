local enhancementInfo = {
    key = 'toast',
    pos = LOSTEDMOD.funcs.coordinate(1),
    atlas = 'losted_enhancements',
    config = { Xmult = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.after and context.scoring_hand then
            calculate_toast_cards(context)
        end
        if context.individual and context.cardarea == G.play then
            return { xmult = card.ability.Xmult }
        end
    end,
}

function calculate_toast_cards(context)
    local toasts_total = {}
    for _, toast_card in ipairs(context.scoring_hand or {}) do
        if toast_card.config.center == G.P_CENTERS.m_losted_toast and not toast_card.debuff then
            if not toast_card.destroyed then
                table.insert(toasts_total, toast_card)

                forced_message(localize('toast_eaten'), toast_card)

                local dissolve_time_fac = 2
                event({
                    trigger = 'before',
                    delay = 0.7*dissolve_time_fac*1.051,
                    func = function()
                        if toast_card and not toast_card.removed then
                            play_sound('losted_eating', 1.0 + (math.random() * 0.1) - 0.05)

                            local dissolve_time = 0.7*(dissolve_time_fac or 1)
                            toast_card:start_dissolve({HEX('ffdfaa')}, nil, dissolve_time_fac)
                        end
                        return true
                    end
                })
                toast_card.destroyed = true
            end
        end
    end
    if #toasts_total > 0 then
        SMODS.calculate_context({remove_playing_cards = true, removed = toasts_total})
    end
end

return enhancementInfo
