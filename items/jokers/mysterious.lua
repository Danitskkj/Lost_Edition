local jokerInfo = {
    key = "mysterious",
    pos = LOSTEDMOD.funcs.coordinate(76),
    soul_pos = LOSTEDMOD.funcs.coordinate(86),
    atlas = 'losted_jokers',
    rarity = 3,
    cost = 8,
    unlocked = false,
    blueprint_compat = false,
    eternal_compat = false,
    config = { extra = { 
        triggered = false,
        played_hands = {
            ["High Card"] = false,
            ["Pair"] = false,
            ["Two Pair"] = false, 
            ["Three of a Kind"] = false,
            ["Straight"] = false,
            ["Flush"] = false,
            ["Full House"] = false,
            ["Four of a Kind"] = false,
            ["Straight Flush"] = false
        }
    }},
    loc_vars = function(self, info_queue, card)
        local completed_hands = 0
        for _, played in pairs(card.ability.extra.played_hands) do
            if played then completed_hands = completed_hands + 1 end
        end
        local total_hands = 9
        return { vars = { completed_hands, total_hands } }
    end,
    calculate = function(self, card, context)
        if not card.ability.extra.triggered then
            if context.main_eval and context.scoring_name and context.after then
                local hand_name = context.scoring_name
                if card.ability.extra.played_hands[hand_name] ~= nil then
                    card.ability.extra.played_hands[hand_name] = true
                    
                    juice_card(card)
                    
                    local all_played = true
                    for _, played in pairs(card.ability.extra.played_hands) do
                        if not played then 
                            all_played = false
                            break
                        end
                    end
                      if all_played then
                        card.ability.extra.triggered = true
                        
                        event({
                            func = function()
                                local current_money = G.GAME.dollars or 0
                                local money_to_steal = math.floor(current_money)
                                
                                ease_dollars(-money_to_steal, true)
                                play_sound('losted_laugh', 1.0, 0.8)
                                card_eval_status_text(card, 'extra', nil, nil, nil, {
                                    message = "HAHAHAHA",
                                    colour = G.C.PURPLE,
                                    scale = 2.0,
                                    delay = 2.0
                                })
                                
                                event({
                                    trigger = 'after',                                    delay = 2.5,
                                    func = function()
                                        LOSTEDMOD.vars.the_joker_triggered = true
                                        LOSTEDMOD.funcs.destroy_joker(card)
                                        return true
                                    end
                                })
                                
                                return true
                            end
                        })
                    end
                end
            end
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win_challenge' and G.GAME.challenge == 'c_losted_marathon' then
            self.challenge_bypass = true
            unlock_card(self)
        end
    end,
}

return jokerInfo