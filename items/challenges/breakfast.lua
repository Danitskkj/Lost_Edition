local challengeInfo = {
    key = 'breakfast',
    rules = {
        modifiers = {
			{ id = "hands", value = 1 },
		},
    },
    deck = {
        type = "Challenge Deck",
        enhancement = 'm_losted_toast',
    },
    jokers = {},
    restrictions = {
        banned_cards = {
            { id = 'j_marble' },
            { id = 'j_vampire' },
            { id = 'j_midas_mask' },
            { id = 'j_certificate' },
            { id = 'j_losted_artist' },
            { id = 'j_losted_error' },
            { id = 'j_losted_miner' },
            { id = 'c_magician' },
            { id = 'c_empress' },
            { id = 'c_heirophant' },
            { id = 'c_chariot' },
            { id = 'c_devil' },
            { id = 'c_justice' },
            { id = 'c_lovers' },
            { id = 'c_tower' },
            { id = 'c_losted_lily' },
            { id = 'c_incantation' },
            { id = 'c_grim' },
            { id = 'c_familiar' },
            { id = 'c_losted_greed' },
            { id = 'v_magic_trick' },
            { id = 'v_illusion' },
            {
                id = 'p_standard_normal_1',
                ids = {
                    'p_standard_normal_1', 'p_standard_normal_2',
                    'p_standard_normal_3', 'p_standard_normal_4',
                    'p_standard_jumbo_1', 'p_standard_jumbo_2',
                    'p_standard_mega_1', 'p_standard_mega_2'
                }
            },
        },
        banned_tags = {
            { id = 'tag_standard' },
        },
        banned_other = {
            { id = 'bl_losted_vampiric', type = 'blind' },
        },
    },
}

return challengeInfo