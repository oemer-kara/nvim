return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		max_time = 1000,
		max_count = 3,
		disable_mouse = true,
		hint = true,
		notification = true,
		allow_different_key = true,
		enabled = true,

		restricted_keys = {
			["h"] = { "n", "x" },
			["l"] = { "n", "x" },
			["j"] = { "n", "x" },
			["k"] = { "n", "x" },
		},

		restriction_mode = "block",

		disabled_keys = {
			["<Left>"] = { "n", "x" },
			["<Right>"] = { "n", "x" },
			["<Up>"] = { "n", "x" },
			["<Down>"] = { "n", "x" },
		},

		disabled_filetypes = {
			"qf",
			"netrw",
			"NvimTree",
			"lazy",
			"mason",
			"oil",
			"terminal",
			"neo-tree",
		},

		hints = {
			["k%^"] = {
				message = function()
					return "Use - instead of k^"
				end,
				length = 2,
			},
			["d[tTfF].i"] = {
				message = function(keys)
					return "Use c" .. keys:sub(2, 3) .. " instead of " .. keys
				end,
				length = 4,
			},
		},

		callback = function(text)
			vim.notify(text, vim.log.levels.WARN)
		end,

		force_exit_insert_mode = false,
		max_insert_idle_ms = 5000,
	},
}
