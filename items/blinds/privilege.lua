local blindInfo = {
    key = 'privilege',
    pos = { x = 0, y = 2 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 4 },
    boss_colour = HEX('ffdf7d'),
    config = { extra = { odds = 8 } }, 

    loc_vars = function(self)
        return { vars = { (G.GAME.probabilities.normal or 1), self.config.extra.odds } }
    end,

    collection_loc_vars = function(self)
        return { vars = { '1', '8' } }
    end,

    drawn_to_hand = function(self)
        if not G.GAME or not G.GAME.blind then return end
        if G.GAME.blind.disabled then return end
        if not G.hand then return end

        G.GAME.losted_privilege = G.GAME.losted_privilege or {}
        local tracking = G.GAME.losted_privilege
        tracking.processed_cards = tracking.processed_cards or {}

        local normal = (G.GAME.probabilities and G.GAME.probabilities.normal) or 1
        local odds = self.config.extra.odds or 8

        for _, card in ipairs(G.hand.cards) do
            local card_key = tostring(card):gsub("table: ", "card_")
            
            if not tracking.processed_cards[card_key] then
                local debuffed = (pseudorandom('losted_privilege_' .. card_key) < normal / odds)
                card.losted_privilege_active = debuffed or nil
                tracking.processed_cards[card_key] = true
                SMODS.recalc_debuff(card)
            end
        end
    end,

    recalc_debuff = function(self, card, from_blind)
        if card.losted_privilege_active then
            return true
        end
        return nil
    end,

    disable = function(self)
        if not G.GAME or not G.GAME.losted_privilege then return end
        
        if G.hand and G.hand.cards then
            for _, card in ipairs(G.hand.cards) do
                if card.losted_privilege_active then
                    card.losted_privilege_active = nil
                    if card.debuff then
                        card:set_debuff(false)
                    end
                end
            end
        end

        G.GAME.losted_privilege.processed_cards = {}
    end,
}

return blindInfo