-- Function to reset the moist cake card suit each round
local function reset_losted_moist_cake()
    G.GAME.current_round.losted_moist_cake = G.GAME.current_round.losted_moist_cake or { suit = 'Spades' }
    local moist_cake_suits = {}
    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.losted_moist_cake.suit then 
            moist_cake_suits[#moist_cake_suits + 1] = v 
        end
    end
    local moist_cake_card = pseudorandom_element(moist_cake_suits, pseudoseed('losted_moist_cake' .. G.GAME.round_resets.ante))
    G.GAME.current_round.losted_moist_cake.suit = moist_cake_card
end

-- Register the reset function
LOSTEDMOD.funcs.reset_losted_moist_cake = reset_losted_moist_cake

local jokerInfo = {
    key = "moist_cake",
    pos = LOSTEDMOD.funcs.coordinate(30),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    config = { extra = { mult = 8 } },
    loc_vars = function(self, info_queue, card)
        G.GAME.current_round.losted_moist_cake = G.GAME.current_round.losted_moist_cake or { suit = 'Spades' }
        local suit = G.GAME.current_round.losted_moist_cake.suit
        return { vars = { card.ability.extra.mult, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
        G.GAME.current_round.losted_moist_cake = G.GAME.current_round.losted_moist_cake or { suit = 'Spades' }
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.losted_moist_cake.suit) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

return jokerInfo