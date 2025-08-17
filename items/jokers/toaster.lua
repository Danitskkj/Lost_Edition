local jokerInfo = {
    key = "toaster",
    pos = LOSTEDMOD.funcs.coordinate(33),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = false,
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_losted_toast
    end,
    calculate = function(self, card, context)
        if context.after and context.main_eval and not context.blueprint and 
           context.scoring_name == 'Pair' then
            
            local pair_cards = {}
            local rank_counts = {}
            
            for _, playing_card in ipairs(context.scoring_hand) do
                local rank = playing_card:get_id()
                rank_counts[rank] = rank_counts[rank] or {}
                table.insert(rank_counts[rank], playing_card)
            end
            
            for rank, cards in pairs(rank_counts) do
                if #cards == 2 then
                    pair_cards = cards
                    break
                end
            end
            
            if #pair_cards == 2 then
                event({
                    trigger = 'after',
                    delay = 0.7,
                    func = function()
                        for _, pair_card in ipairs(pair_cards) do
                            pair_card:set_ability(G.P_CENTERS.m_losted_toast, nil, true)
                            big_juice(pair_card)
                        end
                        big_juice(card)
                        return true
                    end
                })
                
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.ENHANCE
                }
            end
        end
    end
}

return jokerInfo