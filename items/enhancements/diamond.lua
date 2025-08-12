local enhancementInfo = {
    key = 'diamond',
    post_effect = true,
    rescore_amount = 1, 
    pos = LOSTEDMOD.funcs.coordinate(0),
    atlas = 'losted_enhancements',
    config = { h_x_chips = 1.3, h_x_mult = 1.3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_chips, card.ability.h_x_mult } }
    end,
    calculate = function(self, card, context, effect)
        if context.post_effect
        and context.cardarea == G.play
        and context.main_scoring
        and context.scoring_hand
        and ((not card.config.diamond_rescored_times) or (card.config.diamond_rescored_times < card.config.center.rescore_amount)) then

            local card_position
            for position, scoring_card in ipairs(context.scoring_hand) do
                if scoring_card == card then
                    card_position = position
                    break
                end
            end

            local last_in_streak = true
            if context.scoring_hand[card_position + 1] and context.scoring_hand[card_position + 1].config.center == card.config.center and not (context.scoring_hand[card_position + 1].debuff) then
                last_in_streak = false
            end

            if last_in_streak then
                local streak = false
                if context.scoring_hand[card_position - 1] and context.scoring_hand[card_position - 1].config.center == card.config.center and not (context.scoring_hand[card_position - 1].debuff) then
                    streak = true
                end

                if streak then
                    return {
                        func = function()
                            while (card.config.diamond_rescored_times or 0) < card.config.center.rescore_amount do
                                local diamond_chain = {card}
                                local i = 1

                                while true do
                                    if context.scoring_hand[card_position - i]
                                    and context.scoring_hand[card_position - i].config.center == card.config.center
                                    and not (context.scoring_hand[card_position - i].debuff) then
                                        table.insert(diamond_chain, context.scoring_hand[card_position - i])
                                    else
                                        break
                                    end
                                    i = i + 1
                                end
                                
                                for chain_index = #diamond_chain, 1, -1 do
                                    local diamond_card = diamond_chain[chain_index]
                                    event({func = function() 
                                        big_juice(diamond_card) 
                                        return true 
                                    end})
                                end

                                play_area_status_text(localize('k_again_ex'))

                                for chain_index = #diamond_chain, 1, -1 do
                                    local diamond_card = diamond_chain[chain_index]
                                    for _, play_card in ipairs(G.play.cards) do
                                        if play_card == diamond_card then
                                            diamond_card.config.diamond_rescored_times = (diamond_card.config.diamond_rescored_times or 0) + 1
                                            local passed_context = build_smods_post_context(play_card, context, context.scoring_hand)
                                            SMODS.score_card(play_card, passed_context)
                                        end
                                    end
                                end
                                SMODS.calculate_context({rescore_cards = diamond_chain})
                            end
                            
                        end
                    }
                end
            end
        end
        
        -- Reset the diamond rescored counter
        if context.after then
            for _, other_card in ipairs(context.scoring_hand) do
                other_card.config.diamond_rescored_times = 0
            end
        end
    end
}

return enhancementInfo
