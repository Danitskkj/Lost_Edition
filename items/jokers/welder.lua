local jokerInfo = {
    key = "welder",
    pos = LOSTEDMOD.funcs.coordinate(7),
    atlas = 'losted_jokers',
    rarity = 3,
    cost = 8,
    unlocked = false,
    blueprint_compat = false,
    config = {
        extra = {
            steel_xmult = 2.5,
            unlock_req = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return {
            vars = {card.ability.extra.steel_xmult}
        }
    end,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.extra.unlock_req, localize { type = 'name_text', key = 'm_steel', set = 'Enhanced' }},
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card and SMODS.has_enhancement(context.other_card, 'm_steel') then
            context.other_card.ability.h_x_mult = card.ability.extra.steel_xmult
        end
        if context.before and context.main_eval and not context.blueprint then
            local enhanced_cards = 0
            for _, c in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(c, 'm_steel') then
                    c.ability.h_x_mult = card.ability.extra.steel_xmult
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, c in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(c, 'm_steel') then
                c.ability.h_x_mult = 1.5
            end
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(playing_card, 'm_steel') then count = count + 1 end
                if count >= self.config.extra.unlock_req then
                    return true
                end
            end
        end
        return false
    end
}

return jokerInfo