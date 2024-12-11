return {
	"rmagatti/auto-session",
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		-- log_level = 'debug',
	},
	config = function(_, opts)
		require("auto-session").setup(opts)

		-- Custom session save and restore keymaps using leader key
		vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "[s]ave" })
		vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "[r]estore" })
	end,
}
