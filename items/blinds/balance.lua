local blindInfo = {
    key = 'balance',
    pos = { x = 0, y = 8 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 3 },
    boss_colour = HEX('477de3'),
    recalc_debuff = function(self, card, from_blind)
        if card.area ~= G.jokers and not G.GAME.blind.disabled then
            -- I know it doesn't make sense, since stone cards don't have a rank, but there was an error there, so to be sure
            local is_stone = (card.config and card.config.center and card.config.center.key == 'm_stone') or (SMODS and SMODS.has_enhancement and SMODS.has_enhancement(card, 'm_stone'))
            if not is_stone then
                local v = card.base.value
                if v == '2' or v == '4' or v == '6' or v == '8' or v == '10' then
                    return true
                end
            end
        end
        return false
    end
}

return blindInfo