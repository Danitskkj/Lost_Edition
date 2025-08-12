local consumableInfo = {
    key = 'mystery_soul',
    set = 'Spectral',
    pos = LOSTEDMOD.funcs.coordinate(10),
    soul_pos = LOSTEDMOD.funcs.coordinate(20),
    atlas = 'losted_tarots',
    cost = 0,
    unlocked = true,
    hidden = true, -- Never appears in normal pools
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                LOSTEDMOD.funcs.create_joker_in_deck('j_losted_the_joker')
                local the_joker = G.jokers.cards[#G.jokers.cards]
                if the_joker then
                    big_juice(the_joker)
                end
                play_sound('losted_why_so_serious', 1.0, 1.0)
                return true
            end
        })
        
        return {
            message = localize('k_plus_joker'),
            colour = G.C.DARK_EDITION
        }
    end,
    in_pool = function(self)
        return false -- Never appears in normal pools, only from Mysterious trigger
    end
}

return consumableInfo
