local backInfo = {
    key = "chaotic",
    pos = LOSTEDMOD.funcs.coordinate(2),
    atlas = 'losted_backs',
    unlocked = false,
    config = { 
        ante_scaling = 2,
        vouchers = { 'v_overstock_norm' }
    },
    loc_vars = function(self, info_queue, back)
        return {
            vars = { 
                localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' },
                self.config.ante_scaling or 1,
            }
        }
    end,
    apply = function(self)
        G.GAME.starting_params.chaos_limited_randomness = true
        
        event({
            func = function()
                -- Get all available suits and ranks 
                local all_suits = {}
                local all_ranks = {}
                
                for suit_key, _ in pairs(SMODS.Suits) do
                    table.insert(all_suits, suit_key)
                end
                
                for rank_key, _ in pairs(SMODS.Ranks) do
                    table.insert(all_ranks, rank_key)
                end
                
                -- Choose 6 random ranks
                local chosen_ranks = {}
                for i = 1, math.min(6, #all_ranks) do
                    local rank_idx = pseudorandom('chaos_ranks_' .. i, 1, #all_ranks)
                    local rank = all_ranks[rank_idx]
                    table.insert(chosen_ranks, rank)
                    table.remove(all_ranks, rank_idx)
                end
                
                -- Choose 2 random suits
                local chosen_suits = {}
                for i = 1, math.min(2, #all_suits) do
                    local suit_idx = pseudorandom('chaos_suits_' .. i, 1, #all_suits)
                    local suit = all_suits[suit_idx]
                    table.insert(chosen_suits, suit)
                    table.remove(all_suits, suit_idx)
                end
                
                -- Store chosen ranks and suits
                G.GAME.chaos_ranks = chosen_ranks
                G.GAME.chaos_suits = chosen_suits
                
                -- Transform all cards to random combinations within limits
                for _, card in ipairs(G.playing_cards) do
                    -- Choose random rank from the chosen ranks
                    local random_rank = chosen_ranks[pseudorandom('chaos_card_rank', 1, #chosen_ranks)]
                    
                    -- Choose random suit from the chosen suits
                    local random_suit = chosen_suits[pseudorandom('chaos_card_suit', 1, #chosen_suits)]
                    
                    SMODS.change_base(card, random_suit, random_rank)
                end
                return true
            end
        })
    end,
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_losted_fortune'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_losted_fortune' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_losted_fortune') > 0
    end
}

return backInfo
