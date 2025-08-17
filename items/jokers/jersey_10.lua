local jokerInfo = {
    key = "jersey_10",
    pos = LOSTEDMOD.funcs.coordinate(24),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = false,
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        info_queue[#info_queue + 1] = G.P_CENTERS.e_losted_quantum
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local hand = context.full_hand or {}
            if #hand == 1 and hand[1]:get_id() == 10 then
                local ten_card = hand[1]
                if not ten_card.edition then
                    event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            local editions = { 'e_polychrome', 'e_holo', 'e_foil', 'e_losted_quantum' }
                            local random_edition = pseudorandom_element(editions, pseudoseed('jersey_10_edition'))
                            ten_card:set_edition(random_edition, true)
                            big_juice(card)
                            big_juice(ten_card)
                            return true
                        end
                    })
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.DARK_EDITION
                    }
                end
            end
        end
    end
}

return jokerInfo
