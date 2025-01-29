return {
	"echasnovski/mini.indentscope",
	version = false,
	event = {
		"BufReadPost",
		"BufNewFile",
		"BufWritePre",
	},
	opts = {
		symbol = "▏",
		draw = {
			-- Fixed animation speed that's still smooth
			animation = function()
				return 10
			end,
			priority = 2,
		},
		options = {
			try_as_border = true,
			border = "both",
			indent_at_cursor = true,
			responsive = true,
			ignore_first_line = false,
		},
		-- Modern mappings for navigation
		mappings = {
			goto_top = "[i",
			goto_bottom = "]i",
		},
	},
	config = function(_, opts)
		require("mini.indentscope").setup(opts)

		-- Modern highlight with transparency support
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
			fg = "#404040",
			nocombine = true,
		})

		-- Exclude filetypes more elegantly
		local ignore_filetypes = {
			"help",
			"alpha",
			"dashboard",
			"neo-tree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		}

		-- Auto disable for specific filetypes
		vim.api.nvim_create_autocmd("FileType", {
			pattern = ignore_filetypes,
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})

		-- Disable on these buffer types
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				if vim.bo.buftype ~= "" then
					vim.b.miniindentscope_disable = true
				end
			end,
		})
	end,
}
