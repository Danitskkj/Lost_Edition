local jokerInfo = {
    key = "cosmos",
    pos = LOSTEDMOD.funcs.coordinate(41),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = false,
    blueprint_compat = true,
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			for i=1, #G.consumeables.cards do
				if G.consumeables.cards[i].ability.set == "Planet" then
					event({trigger = 'after', func = function()
						(context.blueprint_card or card):juice_up(0.25, 0.25)
					return true end
					})
					SMODS.calculate_effect({xmult = card.ability.extra.xmult}, G.consumeables.cards[i])
				end
			end
			return nil, true
		end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 30, G.PROFILES[G.SETTINGS.profile].career_stats.c_planets_bought } }
    end,
    check_for_unlock = function(self, args)
        local stats = G.PROFILES and G.SETTINGS and G.PROFILES[G.SETTINGS.profile] and G.PROFILES[G.SETTINGS.profile].career_stats or {}
        local current = tonumber(stats.c_planets_bought) or 0
        local meets = current >= 30
        -- Proactively unlock if threshold already met
        if meets then
            if not self.unlocked then unlock_card(self) end
            return true
        end
        if args and args.type == 'career_stat' and args.statname == 'c_planets_bought' then
            if current >= 30 then
                if not self.unlocked then unlock_card(self) end
                return true
            end
        end
        return false
    end
}

return jokerInfo