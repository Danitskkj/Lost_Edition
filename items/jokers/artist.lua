local jokerInfo = {
    key = "artist",   
    pos = LOSTEDMOD.funcs.coordinate(52), 
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = false,
    blueprint_compat = true,
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and next(context.poker_hands['Flush']) then
            if not SMODS.has_enhancement(context.other_card, 'm_wild') and 
                pseudorandom('losted_artist_'..tostring(context.other_card)) < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                context.other_card:set_ability(G.P_CENTERS.m_wild, nil, true)
                context.other_card:juice_up(0.3, 0.4)
                if context.other_card.children and context.other_card.children.center then
                    context.other_card.children.center:set_sprite_pos(G.P_CENTERS.m_wild.pos)
                end
                play_sound('card1', 0.8, 0.8)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.ENHANCE,
                    card = card
                }
            end
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local wild_cards = 0
            for j = 1, #args.cards do
                if args.cards[j].config.center == G.P_CENTERS.m_wild then
                    wild_cards = wild_cards + 1
                end
            end
            if wild_cards >= 5 then
                unlock_card(self)
            end
        end
    end,
}

return jokerInfo
