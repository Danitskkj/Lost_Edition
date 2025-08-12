local jokerInfo = {
    key = 'jimboy',
    pos = LOSTEDMOD.funcs.coordinate(46),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    config = {extra = {chips = 60, mult = 12, mode = 'C'}},
    loc_vars = function(self, info_queue, card)
        local mode_key = card.ability.extra.mode == 'C' and 'k_mod_c' or 'k_mod_m'
        local mode_text = localize(mode_key)
        local mode_color = card.ability.extra.mode == 'C' and G.C.CHIPS or G.C.MULT
        local stat_text = card.ability.extra.mode == 'C' and localize('k_chips') or localize('k_mult')
        local current_value = card.ability.extra.mode == 'C' and card.ability.extra.chips or card.ability.extra.mult
        
        return { 
            vars = { 
                colours = {mode_color},
                card.ability.extra.chips, 
                card.ability.extra.mult, 
                mode_text,
                stat_text,
                current_value
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint then
            local new_mode = card.ability.extra.mode == 'C' and 'M' or 'C'
            local mode_color = new_mode == 'C' and G.C.CHIPS or G.C.MULT
            local mode_key = new_mode == 'C' and 'k_mod_c' or 'k_mod_m'
            
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize(mode_key),
                colour = mode_color
            })
            
            card.ability.extra.mode = new_mode
            
            if card.ability.extra.mode == 'C' then
                card.children.center:set_sprite_pos(LOSTEDMOD.funcs.coordinate(46))
            else
                card.children.center:set_sprite_pos(LOSTEDMOD.funcs.coordinate(45))
            end
        end

        if context.joker_main and card.ability.extra.mode == 'C' then
            return {
                chips = card.ability.extra.chips
            }
        end
        
        if context.joker_main and card.ability.extra.mode == 'M' then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            if card.ability and card.ability.extra and card.ability.extra.mode then
                if card.ability.extra.mode == 'C' then
                    card.children.center:set_sprite_pos(LOSTEDMOD.funcs.coordinate(46))
                else
                    card.children.center:set_sprite_pos(LOSTEDMOD.funcs.coordinate(45))
                end
            end
        end
    end,
    update = function(self, card)
        if card.VT.w <= 0 then
            if card.ability.extra.mode == 'C' then
                card.children.center:set_sprite_pos(LOSTEDMOD.funcs.coordinate(46))
            else
                card.children.center:set_sprite_pos(LOSTEDMOD.funcs.coordinate(45))
            end
        end
    end
}

return jokerInfo