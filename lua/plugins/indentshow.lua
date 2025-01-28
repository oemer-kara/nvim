return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = {
			char = "|", -- Use a lighter or more subtle character if preferred, e.g., "│" or "▏"
		},
		scope = {
			show_start = true, -- Show the start of the scope
			show_end = true, -- Show the end of the scope
			highlight = { "Function", "Label" }, -- Highlight groups for scope
			char = "▏", -- Character to show for scope indicators
		},
		exclude = {
			filetypes = { -- Exclude certain filetypes from showing indent lines
				"help",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
			},
			buftypes = { -- Exclude certain buffer types
				"terminal",
				"nofile",
			},
		},
		whitespace = {
			highlight = { "Whitespace", "NonText" }, -- Highlight groups for whitespace
			remove_blankline_trail = true, -- Remove trailing whitespace on blank lines
		},
	},
	config = function(_, opts)
		require("ibl").setup(opts)
	end,
}
