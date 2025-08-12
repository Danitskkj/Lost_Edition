local jokerInfo = {
    key = "baker",
    pos = LOSTEDMOD.funcs.coordinate(42),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_losted_toast
    end,
    calculate = function(self, card, context)
        if context.setting_blind then

            local toast_card = SMODS.create_card { set = "Base", enhancement = "m_losted_toast", area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            toast_card.playing_card = G.playing_card
            table.insert(G.playing_cards, toast_card)

            G.E_MANAGER:add_event(Event({
                func = function()
                    toast_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.play:emplace(toast_card)
                    return true
                end
            }))
            return {
                message = localize('k_plus_toast'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                    draw_card(G.play, G.deck, 90, 'up')
                    SMODS.calculate_context({ playing_card_added = true, cards = { toast_card } })
                end
            }
        end
    end
}

return jokerInfo
