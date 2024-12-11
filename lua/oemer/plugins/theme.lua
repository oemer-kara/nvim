return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			-- Use the 'cool' style for a balanced pop
			style = "cool",

			-- Disable transparency for a solid, consistent background
			transparent = false,

			-- Enhanced terminal colors for better integration
			term_colors = true,

			-- Diagnostic enhancements with subtle contrast
			diagnostics = {
				darker = true,
				undercurl = true,
				background = true,
			},

			-- Calibrated highlight customizations
			highlights = {
				-- Syntax highlighting with toned-down vibrancy
				["@property"] = { fg = "#89B482", fmt = "bold" }, -- Muted green
				["@function"] = { fg = "#6CB6EB", fmt = "italic" }, -- Sky blue
				["@function.call"] = { fg = "#6FBFC2", fmt = "bold" }, -- Soft teal
				["@keyword"] = { fg = "#C678DD", fmt = "italic" }, -- Soft magenta
				["@type"] = { fg = "#D19A66", fmt = "bold" }, -- Warm orange-brown

				-- Softer comment styling
				Comment = { fg = "#7C8599", fmt = "italic" },

				-- Moderately contrasted search and selection
				Search = { bg = "#D19A66", fg = "#1E2127", fmt = "bold" }, -- Warm orange
				Visual = { bg = "#3E4452", fmt = "bold" }, -- Muted dark gray

				-- Diagnostic highlights with reduced saturation
				DiagnosticError = { fg = "#E06C75", fmt = "bold" }, -- Calibrated red
				DiagnosticWarn = { fg = "#E5C07B", fmt = "bold" }, -- Gold yellow
				DiagnosticInfo = { fg = "#61AFEF", fmt = "bold" }, -- Soft blue
				DiagnosticHint = { fg = "#56B6C2", fmt = "bold" }, -- Soft teal

				-- Line number and cursor line adjustments
				LineNr = { fg = "#5C6370" },
				CursorLineNr = { fg = "#98C379", fmt = "bold" }, -- Soft green for focus
				CursorLine = { bg = "#2C323C" }, -- Subtle background highlight
			},

			-- Balanced color overrides
			colors = {
				bg0 = "#1E2127", -- Neutral dark background
				fg = "#ABB2BF", -- Soft white foreground
				green = "#98C379", -- Subtle green
				red = "#E06C75", -- Refined red
				yellow = "#E5C07B", -- Balanced yellow
				blue = "#61AFEF", -- Soft blue
				purple = "#C678DD", -- Muted purple
				orange = "#D19A66", -- Warm orange
				cyan = "#56B6C2", -- Balanced teal
			},

			-- Plugin integrations with balanced styling
			plugins = {
				treesitter = true,
				cmp = true,
				telescope = true,
				nvim_tree = true,
				indent_blankline = true,
				bufferline = true,
				lsp_saga = true,
				which_key = true,
				hop = true,
				notify = true,
				neotree = true,
			},
		})

		-- Load the colorscheme
		require("onedark").load()
	end,
}
