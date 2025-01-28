return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		require("leap").setup({
			-- Default settings for Leap
			safe_labels = {}, -- Disable safe labels for more direct targeting
			labels = { "f", "d", "s", "j", "k", "l", "a", "g", "h", "n" }, -- Custom labels for faster targeting
			equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }, -- Treat certain characters as equivalent
			max_phase_one_targets = 10, -- Limit the number of targets shown in the first phase
			highlight_unlabeled_phase_one_targets = true, -- Highlight unlabeled targets in the first phase
			case_sensitive = false, -- Case-insensitive searching
			special_keys = {
				repeat_search = "<enter>", -- Key to repeat the last search
				next_target = "<enter>", -- Key to jump to the next target
				prev_target = "<backspace>", -- Key to jump to the previous target
				next_group = "<space>", -- Key to jump to the next group of targets
				prev_group = "<tab>", -- Key to jump to the previous group of targets
				eol = "<end>", -- Key to jump to the end of the line
			},
		})

		-- Add default mappings
		require("leap").add_default_mappings()

		-- Enhanced keybindings for more comfort
		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
		vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { desc = "Leap backward" })
		vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "Leap from window" })

		-- Two-character search with space
		vim.keymap.set({ "n", "x", "o" }, "<space>", "<Plug>(leap-cross-window)", { desc = "Leap cross-window" })

		-- Configure highlight groups for better visibility
		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- Dim backdrop for better focus
		vim.api.nvim_set_hl(0, "LeapMatch", {
			fg = "white",
			bg = "#4a4a59", -- Slightly darker background for better contrast
			bold = true,
			nocombine = true,
		})
		vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
			fg = "#ff007c", -- Bright pink for primary labels
			bold = true,
			nocombine = true,
		})
		vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
			fg = "#00dfff", -- Bright cyan for secondary labels
			bold = true,
			nocombine = true,
		})
		vim.api.nvim_set_hl(0, "LeapLabelSelected", {
			fg = "#ffffff", -- White for selected labels
			bg = "#ff007c", -- Pink background for selected labels
			bold = true,
			nocombine = true,
		})
	end,
}
