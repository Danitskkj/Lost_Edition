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
        return args.type == 'c_planets_bought' and G.PROFILES[G.SETTINGS.profile].career_stats.c_planets_bought >= 30
    end
}

return jokerInfo