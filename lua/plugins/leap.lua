return {
	"ggandor/leap.nvim",

	dependencies = {
		"tpope/vim-repeat",
	},

	config = function()
		require("leap").add_default_mappings()
		require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
		require("leap").opts.highlight_unlabeled_phase_one_targets = true
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")
		vim.api.nvim_create_autocmd("User", {
			pattern = "LeapEnter",
			callback = function()
				vim.cmd.hi("Cursor", "blend=100")
				vim.opt.guicursor:append({ "a:Cursor/lCursor" })
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "LeapLeave",
			callback = function()
				vim.cmd.hi("Cursor", "blend=0")
				vim.opt.guicursor:remove({ "a:Cursor/lCursor" })
			end,
		})
	end,
}
