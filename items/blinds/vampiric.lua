local blindInfo = {
    key = 'vampiric',
    pos = { x = 0, y = 1 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 4 },
    boss_colour = HEX('f31745'),
    config = {},
    loc_vars = function(self)
        return { vars = {} }
    end,

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        local changed = false

        for _, card in ipairs(cards) do
            local enhancements = SMODS.get_enhancements(card)
            if enhancements and next(enhancements) and not card.debuff then
                card:set_ability('c_base', nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        return true
                    end
                }))
                changed = true
            end
        end

        if changed then
            G.GAME.blind_message = {
                message = localize('k_losted_enhancements_removed'),
                colour = G.C.RED
            }
        end

        return mult, hand_chips, false
    end,
}

return blindInfo
