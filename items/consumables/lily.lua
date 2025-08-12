local consumableInfo = {
    key = 'lily',
    set = 'Tarot',
    atlas = 'losted_tarots',
    pos = LOSTEDMOD.funcs.coordinate(2),
    unlocked = true,
    config = { max_highlighted = 1, mod_conv = 'm_losted_stellar' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
    use = function(self, card, area, copier)
        event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                big_juice(card)
                return true
            end
        })
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            })
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.mod_conv])
                    return true
                end
            })
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            })
        end
        event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        })
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
}

return consumableInfo
