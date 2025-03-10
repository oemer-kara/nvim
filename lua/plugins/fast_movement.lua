return {
	"ggandor/leap.nvim",

	-----------------------------------
	-- Configuration
	------------------------------------
	config = function()
		require("leap").opts.safe_labels = {}
		local leap = require("leap")
		leap.setup({})
		require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")
		require("leap").opts.preview_filter = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or ch0:match("%w") and ch1:match("%w") and ch2:match("%w"))
		end

		-----------------------------------
		-- Keybindings
		------------------------------------
		vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
	end,
}
