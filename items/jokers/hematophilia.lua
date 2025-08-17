local jokerInfo = {
    key = "hematophilia",
    pos = LOSTEDMOD.funcs.coordinate(34),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    config = { extra = { mult = 0, mult_gain = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.selling_card and not context.blueprint then
            local destroyed_count = 0
            for i, destroyed_card in ipairs(context.removed) do
                destroyed_count = destroyed_count + 1
            end
            if destroyed_count > 0 then
                card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * destroyed_count)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
        
        if context.joker_main then
            if to_big(card.ability.extra.mult) > to_big(0) then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

local original_start_dissolve = Card.start_dissolve
Card.start_dissolve = function(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.config and self.config.center and self.config.center.set == "Joker" and 
    not G.CONTROLLER.locks.selling_card and G.jokers then
        
        for _, joker in ipairs(G.jokers.cards) do
            if joker.config.center.key == 'j_losted_hematophilia' then
                joker.ability.extra.mult = joker.ability.extra.mult + joker.ability.extra.mult_gain
                event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        big_juice(joker)
                        card_eval_status_text(joker, 'extra', nil, nil, nil, {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.MULT
                        })
                        return true
                    end
                })
            end
        end
    end
    return original_start_dissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

return jokerInfo