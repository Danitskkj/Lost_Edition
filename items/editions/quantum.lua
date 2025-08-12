local editionInfo = {
    key = 'quantum',
    shader = 'quantum',
    config = { extra = { retriggers = 1 } },
    in_shop = true,
    weight = 3,
    extra_cost = 5,
    apply_to_float = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.repetition_only or (context.retrigger_joker_check and context.other_card == card) then
            return {
                repetitions = card.edition.extra.retriggers,
                card = card,
                colour = G.C.GREEN,
                message = localize('k_again_ex')
            }     
        end
    end
}

return editionInfo