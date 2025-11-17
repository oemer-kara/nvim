return {
	"echasnovski/mini.pairs",
	version = false,
	event = "InsertEnter",
	opts = {
		----------------------------------------
		-- PAIRED CHARACTERS
		----------------------------------------
		-- Characters to be paired
		pairs = {
			{ "(", ")" },
			{ "[", "]" },
			{ "{", "}" },
			{ '"', '"' },
			{ "'", "'" },
			{ "`", "`" },
		},

		----------------------------------------
		-- BEHAVIOR SETTINGS
		----------------------------------------
		-- Characters where pair completion is isabled
		disable_in_macro = true,
		disable_in_visualblock = true,
		modes = {
			insert = true,
			command = false,
			terminal = false,
		},
	},
}
