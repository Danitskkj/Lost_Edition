LOSTEDMOD.funcs = {
    -- ==== UTILITY FUNCTIONS ====
    
    coordinate = function(position)
        return { x = position % 10, y = math.floor(position / 10) }
    end,
    
    -- ==== CARD MANIPULATION ====
    
    -- Remove a joker card with animation
    destroy_joker = function(card, after)
        G.E_MANAGER:add_event(Event({
            func = function()
                card.T.r = -0.2
                card:juice_up(0.3, 0.4)
                card.states.drag.is = true
                card.children.center.pinch.x = true
                play_sound('tarot1', 1.0, 0.8)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        card:remove()
                        if after and type(after) == "function" then
                            after()
                        end
                        return true
                    end
                }))
                return true
            end
        }))
    end,

    -- Remove multiple cards with animation
    destroy_cards = function(cards, callback)
        if #cards == 0 then return end
        play_sound('tarot1', 1.0, 0.8)
        
        for _, card in ipairs(cards) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            card:remove()
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
        
        if callback then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                blockable = false,
                func = function()
                    callback()
                    return true
                end
            }))
        end
    end,

    -- Create a joker and add to deck
    create_joker_in_deck = function(joker_key)
        return SMODS.add_card({
            set = 'Joker',
            area = G.jokers,
            key = joker_key,
            bypass_discovery_center = true
        })
    end,

    -- ==== IMPORTED FUNCTIONS FROM BUNCO MOD ====
    
    event = function(config)
        local e = Event(config)
        G.E_MANAGER:add_event(e)
        return e
    end,    
    
    big_juice = function(card)
        card:juice_up(0.7)
    end,

    forced_message = function(message, card, color, delay, juice)
        if delay == true then
            delay = 0.7 * 1.25
        elseif delay == nil then
            delay = 0
        end

        LOSTEDMOD.funcs.event({trigger = 'before', delay = delay, func = function()
            if juice then LOSTEDMOD.funcs.big_juice(juice) end
            card_eval_status_text(
                card,
                'extra',
                nil, nil, nil,
                {message = message, colour = color, instant = true}
            )
            return true
        end})
    end,

    -- Post-effect evaluation for enhanced cards
    post_eval_card = function(card, context)
        if not card then return {} end
        if card.ability.set ~= 'Joker' and card.debuff then return {} end
        context = context or {}
        local ret = {}

        if card.ability.set == 'Enhanced' and card.config.center.post_effect then
            local enhancement = card:calculate_enhancement(context)
            if enhancement then
                ret.enhancement = enhancement
            end
        end

        return ret
    end,
}

-- Make Bunco functions globally available
_G.event = LOSTEDMOD.funcs.event
_G.big_juice = LOSTEDMOD.funcs.big_juice
_G.forced_message = LOSTEDMOD.funcs.forced_message
_G.post_eval_card = LOSTEDMOD.funcs.post_eval_card

math.randomseed(os.time())