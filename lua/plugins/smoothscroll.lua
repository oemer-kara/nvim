return {
	"neoscroll.nvim", -- Add the plugin name
	config = function()
		require("neoscroll").setup({
			mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
			easing = "quadratic",
		})
		local neoscroll = require("neoscroll")
		local keymap = {
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 10 })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 10 })
			end,
		}
		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func)
		end
	end,
}
