local jokerInfo = {
    key = "laser_microjet",
    pos = LOSTEDMOD.funcs.coordinate(50),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = false,
    blueprint_compat = false,
    config = {
        extra = {
            odds = 2,
            cards_rescored = {}
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_losted_diamond
        return {
            vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds}
        }
    end,
    in_pool = function(self)
        for _, c in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(c, 'm_losted_diamond') then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.rescore_cards then
            local condition = true

            for i = 1, #card.ability.extra.cards_rescored do
                if context.rescore_cards[1] == card.ability.extra.cards_rescored[i] then
                    condition = false
                end
            end

            if condition and pseudorandom('laser_microjet' .. G.SEED) < G.GAME.probabilities.normal /
                card.ability.extra.odds then
                context.rescore_cards[1].config.diamond_rescored_times =
                    context.rescore_cards[1].config.diamond_rescored_times - 1
                table.insert(card.ability.extra.cards_rescored, context.rescore_cards[1])
                return {
                    message = localize('k_again_ex'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end
        if context.after then
            card.ability.extra.cards_rescored = {}
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'hand' then
            local diamond_cards = 0
            for _, card in ipairs(args.scoring_hand) do
                if SMODS.has_enhancement(card, 'm_losted_diamond') then
                    diamond_cards = diamond_cards + 1
                end
            end
            return diamond_cards >= 5
        end
        return false
    end
}

return jokerInfo
