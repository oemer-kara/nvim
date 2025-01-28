return {
	"neoscroll.nvim",
	config = function()
		require("neoscroll").setup({
			-- Set mappings for smooth scrolling
			mappings = { "<C-u>", "<C-d>", "<C-b>", "zt", "zz", "zb" },
			-- Hide cursor while scrolling for a cleaner look
			hide_cursor = true,
			-- Stop scrolling at EOF (end of file)
			stop_eof = true,
			-- Respect scrolloff setting (margin from the top/bottom)
			respect_scrolloff = true,
			-- Cursor scrolls alone without moving the window
			cursor_scrolls_alone = true,
			-- Use a smooth easing function for scrolling
			easing_function = "quadratic", -- Options: "quadratic", "cubic", "circular", "sine"
			-- Precompute easing for better performance
			pre_hook = nil,
			post_hook = nil,
		})

		-- Import neoscroll
		local neoscroll = require("neoscroll")

		-- Define custom keymaps for smoother scrolling
		local keymap = {
			["<C-u>"] = { neoscroll.scroll, { -0.5, { duration = 20, easing = "quadratic" } } }, -- Scroll up
			["<C-d>"] = { neoscroll.scroll, { 0.5, { duration = 20, easing = "quadratic" } } }, -- Scroll down
			["<C-b>"] = { neoscroll.scroll, { -1.0, { duration = 200, easing = "circular" } } }, -- Scroll page up
			["zt"] = { neoscroll.zt, { 50, { duration = 100, easing = "sine" } } }, -- Scroll line to top
			["zz"] = { neoscroll.zz, { 50, { duration = 100, easing = "sine" } } }, -- Scroll line to middle
			["zb"] = { neoscroll.zb, { 50, { duration = 100, easing = "sine" } } }, -- Scroll line to bottom
		}

		-- Apply keymaps to normal, visual, and select modes
		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, function()
				func[1](func[2][1], func[2][2]) -- Pass lines and opts
			end, { silent = true, noremap = true })
		end
	end,
}
