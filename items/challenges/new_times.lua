local function starts_with(str, start)
    return string.sub(str, 1, #start) == start
end

local challengeInfo = {
    key = 'new_times',
    rules = {
        custom = {
            { id = "new_times" },
        },
    },
    deck = {
        type = "Challenge Deck",
    },
    restrictions = {
        banned_cards = (function()
            local banned_ids = {}
            for k, v in pairs(G.P_CENTERS) do
                if starts_with(k, "j_") and not starts_with(k, "j_losted_") then
                    table.insert(banned_ids, k)
                end
            end
            return {
                { id = 'j_losted_invisible', ids = banned_ids }
            }
        end)(),
    },
}

return challengeInfo