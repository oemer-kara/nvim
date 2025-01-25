return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		require("leap").add_default_mappings()
		require("leap").opts.safe_labels = {}
		require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")

		-- Enhanced configuration for more comfort
		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")

		-- Two-character search with space
		vim.keymap.set({ "n", "x", "o" }, "<space>", "<Plug>(leap-from-window)")

		-- Configure highlight groups for better visibility
		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
		vim.api.nvim_set_hl(0, "LeapMatch", {
			fg = "white",
			bold = true,
			nocombine = true,
		})
	end,
}
