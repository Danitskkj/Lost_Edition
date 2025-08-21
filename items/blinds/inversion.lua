local blindInfo = {
    key = 'inversion',
    pos = { x = 0, y = 3 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 1 },
    boss_colour = HEX('42b8f5'),
    
    set_blind = function(self, reset, silent)
    if G.GAME and G.GAME.blind and G.GAME.blind.disabled then return end
        -- Store original values
        if not self.original_hands then
            self.original_hands = G.GAME.current_round.hands_left
            self.original_discards = G.GAME.current_round.discards_left
        end
        
        -- Swap hands and discards directly
        local temp_hands = G.GAME.current_round.hands_left
        local temp_discards = G.GAME.current_round.discards_left
        
        G.GAME.current_round.hands_left = temp_discards
        G.GAME.current_round.discards_left = temp_hands
    end,
    
    defeat = function(self, silent)
        -- Restore original values if they exist
        if self.original_hands and self.original_discards then
            G.GAME.current_round.hands_left = self.original_hands
            G.GAME.current_round.discards_left = self.original_discards
            
            -- Clean up stored values
            self.original_hands = nil
            self.original_discards = nil
        end
    end,
    disable = function(self)
        -- Treat disable same as defeat (restore state)
        if self.original_hands and self.original_discards then
            G.GAME.current_round.hands_left = self.original_hands
            G.GAME.current_round.discards_left = self.original_discards
            self.original_hands = nil
            self.original_discards = nil
        end
    end,
    
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

return blindInfo