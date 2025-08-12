local jokerInfo = {
    key = "stake_out",
    pos = LOSTEDMOD.funcs.coordinate(1),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    config = { extra = { xmult = 2, hands = -1, hand_reduced = false } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, -card.ability.extra.hands } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local xmult_return = { xmult = card.ability.extra.xmult }

            if G.GAME.current_round and G.GAME.current_round.hands_left > 0 then
                if G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.triggered then
                    local blacklist = {
                        bl_flint = true,
                        bl_arm = true,
                        bl_tooth = true
                    }

                    local blind_key = G.GAME.blind.key or
                        (G.GAME.blind.config and G.GAME.blind.config.blind and G.GAME.blind.config.blind.key)

                    if blind_key and not blacklist[blind_key] then
                        ease_hands_played(card.ability.extra.hands)
                        play_sound('losted_whistle', 0.9, 0.7)
                    end
                end
            end

            return xmult_return
        end
    end
}

return jokerInfo