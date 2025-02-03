return {
	"ggandor/leap.nvim",
	event = "VeryLazy",
	dependencies = {
		"tpope/vim-repeat", -- for dot repeat support
	},
	config = function()
		require("leap").create_default_mappings()

		-- Custom mappings for 's' to jump forward and backward
		vim.keymap.set({ "n", "x", "o" }, "s", function()
			require("leap").leap({ target_windows = { vim.fn.win_getid() } })
		end, { desc = "Leap forward and backward with 's'" })

		require("leap").opts = {
			safe_labels = {},
			labels = {
				"s",
				"f",
				"n",
				"j",
				"k",
			},
			-- Change special keys if you don't like the defaults
			special_keys = {
				repeat_search = "<enter>",
				next_group = "<space>",
				prev_group = "<tab>",
				next_target = "<enter>",
				prev_target = "<tab>",
				next_match = "<enter>",
				prev_match = "<tab>",
				multi_accept = "<enter>",
				multi_revert = "<backspace>",
			},
		}
	end,
}
