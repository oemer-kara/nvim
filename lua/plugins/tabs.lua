return {
	"echasnovski/mini.tabline",
	version = "*",
	config = function()
		----------------------------------------
		-- MINI.TABLINE SETUP
		----------------------------------------
		require("mini.tabline").setup({
			-- Customize the appearance to match lackluster.nvim theme
			options = {
				show_icons = true, -- Show file icons
				show_filename_only = true, -- Show only filenames (no paths)
				tabpage_section = "right", -- Place tabpage section on the right
			},
		})

		----------------------------------------
		-- KEY MAPPINGS
		----------------------------------------
		vim.keymap.set("n", "<A-.>", "<cmd>bnext<CR>", { desc = "Next tab" }) -- Switch to next tab
		vim.keymap.set("n", "<A-,>", "<cmd>bprevious<CR>", { desc = "Previous tab" }) -- Switch to previous tab
	end,
}
