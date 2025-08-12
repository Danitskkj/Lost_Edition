local jokerInfo = {
    key = "advantage_addiction",
    pos = LOSTEDMOD.funcs.coordinate(23),
    atlas = 'losted_jokers',
    rarity = 3,
    cost = 8,
    unlocked = false,
    blueprint_compat = true,
    config = {
        extra = {
            repetitions = 1,
            unlock_req = 20
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "improvements_of_card", set = "Other"}
        return {
            vars = {card.ability.extra.repetitions}
        }
    end,
    locked_loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "improvements_of_card", set = "Other"}
        return {
            vars = {self.config.extra.unlock_req}
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card then
            local has_advantage = false

            local enhancements = SMODS.get_enhancements(context.other_card)
            if enhancements and next(enhancements) then
                has_advantage = true
            end

            if context.other_card.seal then
                has_advantage = true
            end

            if context.other_card.edition then
                has_advantage = true
            end

            if has_advantage then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end

        if context.repetition and context.cardarea == G.hand and context.other_card then
            local has_advantage = false

            local enhancements = SMODS.get_enhancements(context.other_card)
            if enhancements and next(enhancements) then
                has_advantage = true
            end

            if context.other_card.seal then
                has_advantage = true
            end

            if context.other_card.edition then
                has_advantage = true
            end

            if has_advantage and (next(context.card_effects[1]) or #context.card_effects > 1) then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local enhanced_cards = 0
            for _, card in ipairs(G.playing_cards) do
                if next(SMODS.get_enhancements(card)) or card.seal or card.edition then
                    enhanced_cards = enhanced_cards + 1
                end
            end
            return enhanced_cards >= self.config.extra.unlock_req
        end
        return false
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both')
            and card.sprite_facing == 'front'
            and (card.config.center.discovered or card.bypass_discovery_center)
            and card.config.center.unlocked then
            card.children.center:draw_shader('polychrome', nil, card.ARGS.send_to_shader)
        end
    end
}

return jokerInfo
