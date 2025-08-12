local blindInfo = {
    key = 'annihilation',
    pos = { x = 0, y = 7 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 4 },
    boss_colour = HEX('27b987'),
    press_play = function(self)
        local tags = {}
        for _, tag in ipairs(G.GAME.tags or {}) do
            table.insert(tags, tag)
        end
        local n = #tags
        if n > 1 then
            local idx = math.random(n)
            local tag_to_remove = tags[idx]
            local lock = tag_to_remove.ID
            G.CONTROLLER.locks[lock] = true
            tag_to_remove:yep("-", G.C.RED, function()
                if tag_to_remove.ability and tag_to_remove.ability.orbital_hand then
                    G.orbital_hand = tag_to_remove.ability.orbital_hand
                end
                tag_to_remove:remove()
                G.orbital_hand = nil
                G.CONTROLLER.locks[lock] = nil
                self.triggered = true
                return true
            end)
        end
    end
}

return blindInfo
