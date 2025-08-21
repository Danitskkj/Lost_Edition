local function get_random_visible_hand()
    local _poker_hands = {}
    for k, v in pairs(G.GAME.hands) do
        if v.visible then
            table.insert(_poker_hands, k)
        end
    end
    return pseudorandom_element(_poker_hands, 'labyrinth')
end

local blindInfo = {
    key = "labyrinth",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 5 },
    atlas = "losted_blinds",
    boss = { min = 2 },
    boss_colour = HEX('f37013'),
    debuffed_hand = nil,
    set_blind = function(self)
        self.debuffed_hand = get_random_visible_hand()
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind or not self.debuffed_hand then
                self.debuffed_hand = get_random_visible_hand()
            end
            if context.hand_played or context.hand_drawn then
                self.debuffed_hand = get_random_visible_hand()
            end
            if context.debuff_hand then
                if self.debuffed_hand and self.debuffed_hand == context.scoring_name then
                    return { debuff = true }
                end
            end
        end
    end
}

return blindInfo
