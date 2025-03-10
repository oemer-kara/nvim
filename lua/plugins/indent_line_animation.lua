return {
	"echasnovski/mini.indentscope",

	-----------------------------------
	-- Version & Events
	-----------------------------------
	version = false,
	event = {
		"BufReadPost",
		"BufNewFile",
		"BufWritePre",
	},

	-----------------------------------
	-- Options
	-----------------------------------
	opts = {
		symbol = "┊",
		draw = {
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
		mappings = {
			goto_top = "[i",
			goto_bottom = "]i",
		},
	},

	-----------------------------------
	-- Configuration
	-----------------------------------
	config = function(_, opts)
		require("mini.indentscope").setup(opts)

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

		vim.api.nvim_create_autocmd("FileType", {
			pattern = ignore_filetypes,
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				if vim.bo.buftype ~= "" then
					vim.b.miniindentscope_disable = true
				end
			end,
		})
	end,
}
