return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.smart_send_to_qflist,
					},
					n = {
						["q"] = actions.close,
					},
				},
				file_ignore_patterns = { "node_modules", ".git" },
				layout_strategy = "bottom_pane",
				layout_config = {
					bottom_pane = {
						height = 0.4,
						preview_cutoff = 120,
						prompt_position = "top",
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = { "--hidden", "-g", "!.git" },
				},
			},
		})

		-- Key mappings
		local keymap = vim.keymap
		keymap.set("n", "<C-t>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
		keymap.set("n", "<C-f>", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
	end,
}
