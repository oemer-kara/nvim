return {
	-----------------------------------
	-- Gitsigns (blame, gutter signs, hunk actions)
	-----------------------------------
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				signs = {
					add          = { text = "│" },
					change       = { text = "│" },
					delete       = { text = "_" },
					topdelete    = { text = "‾" },
					changedelete = { text = "~" },
					untracked    = { text = "┆" },
				},
				signs_staged_enable = true,
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 300,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local function bmap(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation between hunks
					bmap("n", "]h", gs.next_hunk, { desc = "Next git hunk" })
					bmap("n", "[h", gs.prev_hunk, { desc = "Previous git hunk" })

					-- Hunk actions
					bmap("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
					bmap("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
					bmap("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage selected hunk" })
					bmap("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selected hunk" })
					bmap("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
					bmap("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
					bmap("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
					bmap("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
					bmap("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
					bmap("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
					bmap("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
					bmap("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Diff against last commit" })
				end,
			})
		end,
	},

	-----------------------------------
	-- Diffview (diff viewer & merge conflict resolution)
	-----------------------------------
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
		},
		opts = {
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
		},
	},

	-----------------------------------
	-- Neogit (full git UI: push, pull, commit, etc.)
	-----------------------------------
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
			{ "<leader>gC", "<cmd>Neogit commit<cr>", desc = "Git commit" },
			{ "<leader>gP", "<cmd>Neogit push<cr>", desc = "Git push" },
			{ "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Git pull" },
		},
		opts = {
			integrations = {
				diffview = true,
				telescope = true,
			},
			signs = {
				section = { "", "" },
				item = { "", "" },
			},
		},
	},
}
