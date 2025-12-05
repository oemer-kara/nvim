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
					"--hidden",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.smart_send_to_qflist,
						["<Esc>"] = actions.close,
					},
					n = {
						["q"] = actions.close,
						["<Esc>"] = actions.close,
					},
				},
				file_ignore_patterns = { "node_modules", ".git" },
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						width = 0.8,
						height = 0.9,
						preview_cutoff = 40,
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
		local builtin = require("telescope.builtin")
		keymap.set("n", "<C-t>", builtin.find_files, { desc = "Find files" })
		keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Live grep" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
		keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find references" })
	end,
}
