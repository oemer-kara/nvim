return {
	"stevearc/dressing.nvim",
	opts = {
		input = {
			-- Customize input window
			default_prompt = "➤ ",
			border = "rounded",
			relative = "editor",
			win_options = {
				winblend = 10,
			},
			mappings = {
				n = {
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
					["<Up>"] = "HistoryPrev",
					["<Down>"] = "HistoryNext",
				},
			},
		},
		select = {
			-- Customize select window
			backend = { "telescope", "fzf", "builtin" },
			telescope = {
				layout_strategy = "center",
				layout_config = {
					width = 0.6,
					height = 0.4,
				},
			},
			builtin = {
				border = "rounded",
				relative = "editor",
				win_options = {
					winblend = 10,
				},
			},
		},
	},
}
