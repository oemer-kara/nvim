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
				MiniTablineCurrent = { fg = "#FFC43D", bg = "#1A1A1A", bold = true }, -- Vibrant yellow for current tab
				MiniTablineVisible = { fg = "#05668D", bg = "#1A1A1A" }, -- Dark blue for visible tabs
				MiniTablineHidden = { fg = "#9CAFB7", bg = "#1A1A1A" }, -- Light gray for hidden tabs
				MiniTablineModifiedCurrent = { fg = "#FFC43D", bg = "#1A1A1A" }, -- Vibrant yellow for modified current tab
				MiniTablineModifiedVisible = { fg = "#04724D", bg = "#1A1A1A" }, -- Dark green for modified visible tabs
				MiniTablineModifiedHidden = { fg = "#6B242D", bg = "#1A1A1A" }, -- Darker red for modified hidden tabs
				MiniTablineFill = { bg = "#1A1A1A" }, -- Dark background for unused space
				MiniTablineTabpagesection = { fg = "#FFC43D", bg = "#1A1A1A" }, -- Vibrant yellow for tabpage section
			},
		})

		-- Keybindings for tab navigation
		vim.keymap.set("n", "<A-.>", "<cmd>bnext<CR>", { desc = "Next tab" }) -- Switch to next tab
		vim.keymap.set("n", "<A-,>", "<cmd>bprevious<CR>", { desc = "Previous tab" }) -- Switch to previous tab
		vim.keymap.set("n", "<A-n>", "<cmd>tabnew<CR>", { desc = "New tab" }) -- Create a new tab
	end,
}
