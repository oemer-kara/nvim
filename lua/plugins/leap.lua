return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		require("leap").setup({
			-- Enable direct targeting (single keystroke jumps)
			safe_labels = {}, -- Disable safe labels to allow direct targeting
			labels = {
				"a",
				"s",
				"d",
				"w",
				"q",
				"e",
				"r",
				"f",
				"j",
				"k",
				"l",
				"h",
				"n",
				"m",
				"v",
				"c",
				"1",
				"2",
				"3",
				"4",
				"5",
			}, -- Add more labels for multi-character targeting
			highlight_unlabeled_phase_one_targets = true, -- Highlight unlabeled targets in the first phase
			max_phase_one_targets = 50, -- Increase the number of targets shown in the first phase
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

		-- Enhanced keybindings for single keystroke jumps
		vim.keymap.set({ "n", "x", "o" }, "s", function()
			require("leap").leap({ target_windows = { vim.fn.win_getid() } })
		end, { desc = "Leap forward with single keystroke" })

		vim.keymap.set({ "n", "x", "o" }, "S", function()
			require("leap").leap({ target_windows = { vim.fn.win_getid() }, backward = true })
		end, { desc = "Leap backward with single keystroke" })

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
