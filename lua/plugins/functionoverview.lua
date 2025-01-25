return {
	"rmagatti/goto-preview",
	config = function()
		require("goto-preview").setup({
			width = 100,
			height = 20,
			border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
			default_mappings = false,
			focus_on_open = true,
			dismiss_on_move = false,
		})

		-- Keymaps
		local goto_preview = require("goto-preview")
		vim.keymap.set("n", "gpd", goto_preview.goto_preview_definition)
		vim.keymap.set("n", "gpt", goto_preview.goto_preview_type_definition)
		vim.keymap.set("n", "gpi", goto_preview.goto_preview_implementation)

		-- Close preview on Escape
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = "*",
			callback = function()
				vim.keymap.set("n", "<Esc>", goto_preview.close_all_win, { buffer = true })
			end,
		})
	end,
}
