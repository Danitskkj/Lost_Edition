local blindInfo = {
    key = 'all_ones',
    pos = { x = 0, y = 0 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 5 },
    boss_colour = HEX('50bf7c'),
    config = {
        original_probabilities = nil
    },

    set_blind = function(self, card, from_debuff)
        self.config.original_probabilities = {}
        for k, v in pairs(G.GAME.probabilities) do
            self.config.original_probabilities[k] = v
            G.GAME.probabilities[k] = v / 2
        end
    end,

    disable = function(self, card, from_debuff)
        if self.config.original_probabilities then
            for k, v in pairs(self.config.original_probabilities) do
                G.GAME.probabilities[k] = v
            end
            self.config.original_probabilities = nil
        end
    end,

    defeat = function(self, card, from_debuff)
        if self.config.original_probabilities then
            for k, v in pairs(self.config.original_probabilities) do
                G.GAME.probabilities[k] = v
            end
            self.config.original_probabilities = nil
        end
    end,
}

return blindInfo