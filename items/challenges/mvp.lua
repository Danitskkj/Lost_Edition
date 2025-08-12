-- Challenge by Prism mod (I loved this idea, sorry for stealing)
local challengeInfo = {
    key = 'mvp',
	rules = {
		custom = {
		},
		modifiers = {
		}
	},
	jokers = {
		{id = 'j_blueprint', eternal = true},
		{id = 'j_blueprint', eternal = true},
		{id = 'j_brainstorm', eternal = true},
		{id = 'j_brainstorm', eternal = true},
	},
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			{id = 'v_blank'},
			{id = 'v_antimatter'},
			{id = 'c_ectoplasm'},
		},
		banned_tags = {
			{id = 'tag_negative'},
		},
		banned_other = {
			{id = 'bl_final_acorn', type = 'blind'},
			{id = 'bl_final_heart', type = 'blind'},
			{id = 'bl_final_leaf', type = 'blind'}
		},
	},
}

return challengeInfo