return {
	{
		"stevearc/quicker.nvim",
		config = function()
			require("quicker").setup({
				opts = {
					buflisted = true,
					number = true, -- line numbers in quickfix window
					relativenumber = true, -- relative line numbers in quickfix window
					signcolumn = "auto",
					winfixheight = true,
					wrap = false,
				},

				use_default_opts = true, -- Set to false to disable the default options in `opts`
				constrain_cursor = true, -- Keep the cursor to the right of the filename and lnum columns
				trim_leading_whitespace = "all", -- can be 'all' or 'common'
				max_filename_width = function()
					return 10
				end, -- Maximum width of the filename column

				-- keys = { { ">", "<cmd>lua require('quicker').expand()<CR>", desc = "Expand quickfix content" },  },
				-- on_qf = function(bufnr) end, -- Callback function to run any custom logic or keymaps for the quickfix buffer

				edit = {
					enabled = true, -- Enable editing the quickfix like a normal buffer
					autosave = "true", -- true: write to buffers,  unmodified: write only to unmodified buffers
				},

				highlight = {
					treesitter = true, -- Use treesitter highlighting
					lsp = true, -- Use LSP semantic token highlighting
					load_buffers = true, -- Load the referenced buffers to apply more accurate highlights (may be slow)
				},

				follow = {
					enabled = true, -- When quickfix window is open, scroll to closest item to the cursor
				},

				type_icons = {
					E = "󰅚 ",
					W = "󰀪 ",
					I = " ",
					N = " ",
					H = " ",
				},
			})
		end,
	},
}
