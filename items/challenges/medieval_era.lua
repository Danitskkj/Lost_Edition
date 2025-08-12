local challengeInfo = {
    key = 'medieval_era',
    rules = {
        custom = {
            { id = "boss_rush" },
            { id = "no_tags" },
        },
        modifiers = {},
    },
    deck = {
        type = "Challenge Deck",
    },
    restrictions = {
		banned_cards = {
			{ id = "j_luchador" },
			{ id = "j_chicot" },
			{ id = "j_throwback" },
			{ id = "j_diet_cola" },
			{ id = "v_directors_cut" },
			{ id = "v_retcon" },
		},
		banned_other = {},
	},
}
return challengeInfo