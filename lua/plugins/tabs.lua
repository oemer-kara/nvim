return {
	"echasnovski/mini.tabline",
	version = "*",
	config = function()
		require("mini.tabline").setup({
			-- Customize the appearance to match lackluster.nvim theme
			options = {
				show_icons = true, -- Show file icons
				show_filename_only = true, -- Show only filenames (no paths)
				tabpage_section = "right", -- Place tabpage section on the right
				set_vim_settings = true, -- Ensure Neovim settings for tabline are enabled
			},
			-- Custom highlights to match lackluster.nvim theme
			highlights = {
				MiniTablineCurrent = { fg = "#FF6F61", bg = "#333333", bold = true }, -- Coral for current tab
				MiniTablineVisible = { fg = "#6B5B95", bg = "#1A1A1A" }, -- Purple for visible tabs
				MiniTablineHidden = { fg = "#BBBBBB", bg = "#1A1A1A" }, -- Light gray for hidden tabs
				MiniTablineModifiedCurrent = { fg = "#FFA500", bg = "#333333" }, -- Orange for modified current tab
				MiniTablineModifiedVisible = { fg = "#FFD700", bg = "#1A1A1A" }, -- Gold for modified visible tabs
				MiniTablineModifiedHidden = { fg = "#50C878", bg = "#1A1A1A" }, -- Green for modified hidden tabs
				MiniTablineFill = { bg = "#1A1A1A" }, -- Dark background for unused space
				MiniTablineTabpagesection = { fg = "#FFD700", bg = "#1A1A1A" }, -- Gold for tabpage section
			},
		})

		-- Keybindings for tab navigation
		vim.keymap.set("n", "<A-.>", "<cmd>bnext<CR>", { desc = "Next tab" }) -- Switch to next tab
		vim.keymap.set("n", "<A-,>", "<cmd>bprevious<CR>", { desc = "Previous tab" }) -- Switch to previous tab
		vim.keymap.set("n", "<A-n>", "<cmd>tabnew<CR>", { desc = "New tab" }) -- Create a new tab
	end,
}
