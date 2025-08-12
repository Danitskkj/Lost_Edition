local jokerInfo = {
    key = "seal_stamp",
    pos = LOSTEDMOD.funcs.coordinate(39),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    config = { extra = {} },
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then            
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                event({
                    func = function()
                        local keys = {'c_trance', 'c_deja_vu', 'c_talisman', 'c_medium'}
                        local key = keys[pseudorandom('losted_seal_stamp', 1, 4)]
                        
                        SMODS.add_card({
                            set = 'Spectral',
                            area = G.consumeables,
                            key = key,
                            skip_materialize = false
                        })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                })
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.PURPLE
                }
            end
        end
    end
}

return jokerInfo