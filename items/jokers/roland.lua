local jokerInfo = {
    key = "roland",
    pos = LOSTEDMOD.funcs.coordinate(73),
    soul_pos = LOSTEDMOD.funcs.coordinate(83),
    atlas = 'losted_jokers',
    rarity = 4, 
    cost = 20,
    unlocked = false,
    blueprint_compat = true,
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local spectral_card
                    
                    -- Use the same soul rate as the base game
                    local soul_rate = 0.003
                    local is_soul = pseudorandom('soul') < soul_rate
                    
                    if is_soul then
                        -- Creates a Soul 
                        spectral_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_soul')
                        spectral_card:add_to_deck()
                        G.consumeables:emplace(spectral_card)
                    else
                        -- Creates a random spectral using SMODS.add_card
                        spectral_card = SMODS.add_card({
                            set = 'Spectral',
                            key_append = 'losted_roland'
                        })
                    end
                    
                    -- Apply negative edition if card was created
                    if spectral_card then
                        spectral_card:set_edition("e_negative", true)
                        play_sound('losted_fart', 1, 1)
                    end
                    
                    return true
                end
            }))
            return {
                message = localize('k_plus_spectral'),
                colour = G.C.SECONDARY_SET.Spectral
            }
        end
    end,
}

return jokerInfo
