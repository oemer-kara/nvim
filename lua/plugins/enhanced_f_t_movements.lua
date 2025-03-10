return {
	"ggandor/flit.nvim",

	-----------------------------------
	-- Dependencies
	-----------------------------------
	dependencies = { "ggandor/leap.nvim" },

	-----------------------------------
	-- Options
	-----------------------------------
	opts = {
		keys = { f = "f", F = "F", t = "t", T = "T" },
		labeled_modes = "v",
		clever_repeat = true,
		multiline = true,
		opts = {},
	},
}
