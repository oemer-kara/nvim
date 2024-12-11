return {
	"backdround/improved-ft.nvim",
	config = function()
		local ft = require("improved-ft")

		ft.setup({
			use_default_mappings = true,
			ignore_char_case = true,
			use_relative_repetition = true,
			use_relative_repetition_offsets = true,
		})

		local map = function(key, fn, description)
			vim.keymap.set({ "n", "x", "o" }, key, fn, {
				desc = description,
				expr = true,
			})
		end

		map("f", ft.hop_forward_to_char, "Hop forward to a given char")
		map("F", ft.hop_backward_to_char, "Hop backward to a given char")
		map("t", ft.hop_forward_to_pre_char, "Hop forward before a given char")
		map("T", ft.hop_backward_to_pre_char, "Hop backward before a given char")
		map(";", ft.repeat_forward, "Repeat hop forward to a last given char")
		map(",", ft.repeat_backward, "Repeat hop backward to a last given char")
	end,
	priority = 50,
}
