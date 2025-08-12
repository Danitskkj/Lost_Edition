-- This file contains function overrides and modifications

-- Add editions to wheel of fortune and aura
SMODS.Consumable:take_ownership('wheel_of_fortune', {
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        info_queue[#info_queue+1] = G.P_CENTERS.e_losted_quantum
        info_queue[#info_queue+1] = G.P_CENTERS.e_losted_glitched

        local vars = G.GAME and G.GAME.probabilities.normal and 
                    {G.GAME.probabilities.normal, self.config.extra} or {1, self.config.extra}
        return {key = 'c_losted_wheel_of_fortune', vars = vars}
    end
})

SMODS.Consumable:take_ownership('aura', {
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        info_queue[#info_queue+1] = G.P_CENTERS.e_losted_quantum
        info_queue[#info_queue+1] = G.P_CENTERS.e_losted_glitched
        return {key = 'c_losted_aura'}
    end
})

SMODS.Booster:take_ownership_by_kind('Arcana', {
    create_card = function(self, card, i)
        if LOSTEDMOD and LOSTEDMOD.vars and LOSTEDMOD.vars.the_joker_triggered and i == 1 then
            LOSTEDMOD.vars.the_joker_triggered = false -- Reset the trigger after use
            return {
                set = "Spectral", 
                area = G.pack_cards, 
                skip_materialize = true, 
                soulable = false, 
                key = "c_losted_mystery_soul"
            }
        else
            if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
                return {set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar2"}
            else
                return {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar1"}
            end
        end
    end
})

SMODS.Edition:take_ownership('negative', {
    get_weight = function(self)
        return ((G.GAME.negative_rate or 1) - 1) * self.weight + (G.GAME.negative_rate or 1) * self.weight
    end,
})

function build_smods_post_context(card, context, scoring_hand)
    local passed_context = {}
    for k, v in pairs(context) do
        passed_context[k] = v
    end
    passed_context.cardarea = G.play
    passed_context.main_scoring = true
    passed_context.post_effect = true
    passed_context.scoring_hand = scoring_hand
    passed_context.other_card = card
    passed_context.hand = G.hand
    passed_context.full_hand = G.play.cards
    return passed_context
end

local original_calculate_main_scoring = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
    original_calculate_main_scoring(context, scoring_hand)
    for _, card in ipairs(scoring_hand or context.cardarea.cards) do
        local post_context = build_smods_post_context(card, context, scoring_hand)
        SMODS.trigger_effects({post_eval_card(card, post_context)}, card)
    end
end

-- Override poll_edition to also ban 'e_losted_plasma' when no_neg is true (prevents plasma edition in play card pools)
local poll_edition_original = poll_edition
function poll_edition(key, mod, no_neg, guaranteed, options)
    local result = poll_edition_original(key, mod, no_neg, guaranteed, options)
    if no_neg and result == 'e_losted_plasma' then
        if guaranteed then
            repeat
                result = poll_edition_original(key .. '_reroll', mod, no_neg, guaranteed, options)
            until result ~= 'e_losted_plasma'
            return result
        else
            return nil
        end
    end
    return result
end

sendDebugMessage("[Lost Edition] Override hooks loaded")
return true