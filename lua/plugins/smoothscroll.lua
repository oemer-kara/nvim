return {
	"neoscroll.nvim", -- Add the plugin name
	config = function()
		require("neoscroll").setup({
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
			easing = "quadratic",
		})
		local neoscroll = require("neoscroll")
		local keymap = {
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 30 })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 30 })
			end,
			["<C-b>"] = function()
				neoscroll.ctrl_b({ duration = 50 })
			end,
			["<C-f>"] = function()
				neoscroll.ctrl_f({ duration = 30 })
			end,
			["zt"] = function()
				neoscroll.zt({ duration = 40 })
			end,
			["zz"] = function()
				neoscroll.zz({ duration = 40 })
			end,
			["zb"] = function()
				neoscroll.zb({ duration = 40 })
			end,
		}
		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func)
		end
	end,
}
