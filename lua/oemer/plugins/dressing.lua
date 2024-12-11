return {
	"stevearc/dressing.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"gbprod/cutlass.nvim", -- Optional: for cleaner cut/paste behavior
		"echasnovski/mini.nvim", -- For additional UI enhancements
	},
	event = "VeryLazy",
	config = function()
		local telescope_themes = require("telescope.themes")

		require("dressing").setup({
			input = {
				-- Modern, minimalist input style
				prompt_prefix = "❯ ", -- Sleek prompt symbol
				relative = "editor",
				border = "rounded",

				-- Refined visual aesthetics
				title_pos = "center",
				win_options = {
					winblend = 15,
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Title:FloatTitle",
				},

				-- Enhanced input behavior
				start_in_insert = true,
				insert_only = false,

				-- Sophisticated mappings
				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<C-p>"] = "HistoryPrev",
						["<C-n>"] = "HistoryNext",
					},
				},

				-- Responsive width management
				min_width = { 60, 0.4 },
				max_width = { 140, 0.8 },
			},

			select = {
				-- Advanced selection backends
				backend = {
					"telescope",
					"fzf",
					"builtin",
				},

				-- Telescope-powered selection
				telescope = telescope_themes.get_dropdown({
					layout_config = {
						width = 0.7,
						height = 0.6,
					},
					theme = "dropdown",
					sorting_strategy = "ascending",
					previewer = false,
					borderchars = {
						prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
					},
				}),

				-- Fallback builtin selection
				builtin = {
					border = "rounded",
					winblend = 20,
					preview = {
						enable = true,
						scrollbar = false,
					},

					-- Positioning and styling
					anchor = "NW",
					relative = "cursor",
					row = 1,
					col = 0,
				},

				-- FZF configuration for fuzzy finding
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
				},
			},

			-- Global aesthetic configurations
			border = "rounded",
			winblend = 15,

			-- Refined highlighting
			highlight = {
				border = "FloatBorder",
				background = "NormalFloat",
				title = "FloatTitle",
			},
		})

		-- Optional: Add some extra UI refinements
		require("mini.cursorword").setup()
		require("mini.indentscope").setup()
	end,
}
