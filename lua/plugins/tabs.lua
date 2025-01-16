return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		vim.opt.showtabline = 2

		require("bufferline").setup({
			options = {
				mode = "buffers",
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,

				indicator = {
					icon = "▎",
					style = "icon",
				},
				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",

				separator_style = "thin",

				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},

				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,

				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true,
					},
				},
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				persist_buffer_sort = true,
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				sort_by = "id",
			},
		})

		-- Keymaps for navigating buffers
		vim.keymap.set("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

		-- Additional useful keymaps (optional)
		vim.keymap.set("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
		vim.keymap.set("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
		vim.keymap.set("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
		vim.keymap.set("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
		vim.keymap.set("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
		vim.keymap.set("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })

		-- Commands for sorting buffers (optional)
		vim.keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
		vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick buffer to close" })
		vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close all buffers to the left" })
		vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close all buffers to the right" })
	end,
}
