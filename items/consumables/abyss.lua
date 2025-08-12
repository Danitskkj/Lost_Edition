local consumableInfo = {
    key = 'abyss',
    set = 'Tarot',
    atlas = 'losted_tarots',
    pos = LOSTEDMOD.funcs.coordinate(0),
    unlocked = true,
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
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
                    assert(SMODS.modify_rank(G.hand.highlighted[i], -1))
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
}

return consumableInfo
