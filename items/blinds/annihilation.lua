local blindInfo = {
    key = 'annihilation',
    pos = { x = 0, y = 7 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 4 },
    boss_colour = HEX('27b987'),
    press_play = function(self)
        local tags = G.GAME.tags or {}
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
                -- Properly remove the tag from the G.GAME.tags array
                for i = #G.GAME.tags, 1, -1 do
                    if G.GAME.tags[i] == tag_to_remove then
                        table.remove(G.GAME.tags, i)
                        break
                    end
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
