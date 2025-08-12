local jokerInfo = {
    key = "magician",
    pos = LOSTEDMOD.funcs.coordinate(16),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    config = { extra = { odds = 6 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Tarot" then       
            if pseudorandom('losted_magician') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                event({
                    trigger = 'after',
                    delay = 0.05,
                    func = function()
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            event({
                                func = function()
                                    SMODS.add_card({
                                        set = 'Spectral',
                                        area = G.consumeables,
                                        key_append = 'losted_magician'
                                    })
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end
                            })
                        end
                        return true
                    end
                })
            end
        end
    end,
}

return jokerInfo