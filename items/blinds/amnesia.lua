local blindInfo = {
    key = 'amnesia',
    pos = { x = 0, y = 4 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 6 },
    boss_colour = HEX('f0a426'),
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}}
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played')}}
    end,
    set_blind = function(self)
        local most_played_hand = G.GAME.current_round.most_played_poker_hand
        if most_played_hand and G.GAME.hands[most_played_hand] then
            local original_level = G.GAME.hands[most_played_hand].level
            if original_level > 1 then
                self.most_played_hand_key = most_played_hand
                self.level_change = original_level - 1
            
                SMODS.smart_level_up_hand(nil, self.most_played_hand_key, false, -self.level_change)
            end
        end
    end,
    defeat = function(self)
        self:restore_hand_level()
    end,
    calculate = function(self, blind, context)
        if context.end_of_round then
            self:restore_hand_level()
        end
    end,
    restore_hand_level = function(self)
        if self.level_change and self.most_played_hand_key and G.GAME.hands[self.most_played_hand_key] then
            SMODS.smart_level_up_hand(nil, self.most_played_hand_key, false, self.level_change)
        
            self.level_change = nil
            self.most_played_hand_key = nil
        end
    end
}

return blindInfo