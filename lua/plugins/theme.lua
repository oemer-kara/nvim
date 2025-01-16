return {
	{
		"savq/melange-nvim",
		priority = 1000, -- Load theme before other plugins
		config = function()
			-- Enable true colors
			vim.opt.termguicolors = true

			-- Set up cursor colors (green cursor as requested)
			vim.opt.guicursor = {
				"n-v-c:block-Cursor",
				"i:ver100-iCursor",
				"r:hor20-rCursor",
				"ci-ve:ver25-veCursor",
			}

			-- Configure cursor highlights
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					vim.api.nvim_set_hl(0, "Cursor", { fg = "black", bg = "#00FF00", bold = true })
					vim.api.nvim_set_hl(0, "iCursor", { fg = "black", bg = "#00FF00" })
					vim.api.nvim_set_hl(0, "rCursor", { fg = "black", bg = "#00FF00" })
					vim.api.nvim_set_hl(0, "veCursor", { fg = "black", bg = "#00FF00" })
				end,
			})

			-- Optional: Set background (remove or change if you prefer dark/light)
			vim.opt.background = "dark" -- or 'light'

			-- Load the colorscheme
			vim.cmd.colorscheme("melange")
		end,
	},

	-- Optional: Add lualine for better status line with melange theme
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"savq/melange-nvim",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "melange", -- Use melange theme for lualine
				},
			})
		end,
	},
}
