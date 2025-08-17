local jokerInfo = {
    key = "mitosis",
    pos = LOSTEDMOD.funcs.coordinate(14),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = false,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "improvements_of_card", set = "Other" }
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            local full_hand = context.full_hand
            if not full_hand or #full_hand < 2 then return end

            local first_rank = full_hand[1]:get_id()
            for i = 2, #full_hand do
                if full_hand[i]:get_id() ~= first_rank then
                    return 
                end
            end

            local source_card = full_hand[#full_hand] 
            local any_copied = false

            for i = 1, #full_hand - 1 do
                local target_card = full_hand[i]
                
                if source_card.edition then
                    target_card:set_edition(source_card.edition, true)
                    any_copied = true
                end

                if source_card.seal then
                    target_card:set_seal(source_card.seal)
                    any_copied = true
                end

                local enhancements = SMODS.get_enhancements(source_card)
                if enhancements and next(enhancements) then
                    for enh_key, _ in pairs(enhancements) do
                        target_card:set_ability(enh_key, nil, true)
                    end
                    any_copied = true
                end
            end

            if any_copied then
                for i = 1, #full_hand - 1 do
                    local animated_card = full_hand[i]
                    event({
                        func = function()
                            animated_card:juice_up(0.3, 0.4)
                            play_sound('card1', 0.8 + (i * 0.05), 0.8)
                            return true
                        end,
                        delay = 0.1 * i
                    })
                end
                
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.PURPLE
                }
            end
        end
    end
}

return jokerInfo