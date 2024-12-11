return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		focus = true,
		-- Additional configuration options
		mode = "document_diagnostics", -- default mode
		severity = vim.diagnostic.severity.ERROR, -- filter by severity
		signs = {
			-- customize signs for different severity levels
			error = "DAMN",
			warning = "--->>>>>>>",
			hint = "",
			information = "",
		},
		-- Customize how the trouble window is displayed
		position = "bottom", -- "bottom", "top", "left", "right"
		height = 10, -- height of the trouble list
		width = 50, -- width if position is left or right
	},
	cmd = "Trouble",
	keys = {
		-- Your existing keymaps
		{ "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "[b]uffer diagnostics" },
		{
			"<leader>dw",
			"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<CR>",
			desc = "[w]orkspace diagnostics",
		},
	},
}
