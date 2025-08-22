return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")

		-- Configure toggleterm with simple, cross-platform settings
		toggleterm.setup({
			direction = "horizontal",
			size = 20,
			start_in_insert = true,
			close_on_exit = true,
			auto_scroll = true,
		})

		-- Basic keybindings for terminal
		-- Toggle terminal
		vim.api.nvim_set_keymap("n", "<C-\\>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("t", "<C-\\>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })

		-- Exit terminal mode
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
	end,
}
