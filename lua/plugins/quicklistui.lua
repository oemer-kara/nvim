return {
	{
		"stevearc/quicker.nvim",
		config = function()
			require("quicker").setup({
				opts = {
					buflisted = true,
					number = true,
					relativenumber = true,
					signcolumn = "yes",
					winfixheight = true,
					wrap = false,
					colorcolumn = "80",
				},
				use_default_opts = false,
				constrain_cursor = true,
				trim_leading_whitespace = "all",
				max_filename_width = function()
					return 16
				end,
				keys = {
					{ ">", "<cmd>lua require('quicker').expand()<CR>", desc = "Expand" },
					{ "<", "<cmd>lua require('quicker').collapse()<CR>", desc = "Collapse" },
					{ "q", "<cmd>close<CR>", desc = "Close" },
				},
				edit = {
					enabled = true,
					autosave = true,
				},
				highlight = {
					treesitter = true,
					lsp = true,
					load_buffers = true,
				},
				follow = {
					enabled = true,
					center = true,
				},
				type_icons = {
					E = "✗ ",
					W = "! ",
					I = "i ",
					N = "→ ",
					H = "? ",
				},
				formatting = {
					filename = function(filename)
						return "[" .. filename .. "]"
					end,
					linenr = function(lnum, col)
						return string.format("(%d:%d)", lnum, col)
					end,
				},
			})

			vim.cmd([[
                hi QuickFixLine guibg=#404040 guifg=#00ff00
                hi qfFileName guifg=#00ff00
                hi qfLineNr guifg=#ffff00
                hi qfError guifg=#ff0000
                hi qfWarning guifg=#ffff00
                hi qfInfo guifg=#00ffff
                hi qfHint guifg=#0000ff
            ]])
		end,
	},
}
