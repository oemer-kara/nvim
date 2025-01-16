return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		local leap = require("leap")

		-- Basic setup
		leap.add_default_mappings()

		-- Enhance comfort settings
		leap.opts = {
			-- Completely disable auto-jumping
			safe_labels = {},
			labels = {}, -- This forces manual selection even for single matches

			-- Group similar characters for easier targeting
			equivalence_classes = {
				" \t\r\n", -- Whitespace characters
				"([{", -- Opening brackets
				")]}", -- Closing brackets
				"'\"`", -- Quotes
			},
			-- Make all targets visible immediately
			highlight_unlabeled_phase_one_targets = true,
			-- Increase target visibility
			highlight_positioned_targets = true,

			-- Enhanced visual feedback
			special_keys = {
				next_target = "<enter>",
				prev_target = "<backspace>",
				next_group = "<space>",
				prev_group = "<tab>",
			},
		}

		-- Set repeat keys for better navigation
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")

		-- Make cursor more prominent during leap
		vim.api.nvim_create_autocmd("User", {
			pattern = "LeapEnter",
			callback = function()
				vim.cmd.hi("Cursor", "blend=100")
				vim.opt.guicursor:append({
					"a:block-Cursor/lCursor-blinkon0",
					"i-ci-ve:ver25-Cursor/lCursor-blinkon100",
				})
			end,
		})

		-- Restore cursor settings after leap
		vim.api.nvim_create_autocmd("User", {
			pattern = "LeapLeave",
			callback = function()
				vim.cmd.hi("Cursor", "blend=0")
				vim.opt.guicursor:remove({
					"a:block-Cursor/lCursor-blinkon0",
					"i-ci-ci-ve:ver25-Cursor/lCursor-blinkon100",
				})
			end,
		})

		-- Additional highlighting for better visibility
		vim.cmd([[
            hi! link LeapMatch Search
            hi! link LeapLabelPrimary IncSearch
            hi! link LeapLabelSecondary IncSearch
        ]])
	end,
}
