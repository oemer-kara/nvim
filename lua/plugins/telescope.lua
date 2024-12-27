return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local builtin = require("telescope.builtin")

		local custom_actions = transform_mod({
			preview_scroll_up = function(prompt_bufnr)
				actions.preview_scrolling_up(prompt_bufnr)
			end,

			preview_scroll_down = function(prompt_bufnr)
				actions.preview_scrolling_down(prompt_bufnr)
			end,

			close_telescope = function(prompt_bufnr)
				actions.close(prompt_bufnr)
			end,
		})

		telescope.setup({
			defaults = {
				path_display = {
					"smart",
					shorten = { len = 3, exclude = { -2, -1 } },
				},

				preview = {
					treesitter = true,
					check_mime_type = true,
				},

				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-u>"] = custom_actions.preview_scroll_up,
						["<C-d>"] = custom_actions.preview_scroll_down,
						["<C-q>"] = custom_actions.smart_send_to_qflist,
						["<M-h>"] = actions.select_horizontal,
						["<M-v>"] = actions.select_vertical,
						["<C-x>"] = actions.delete_buffer,
						["<Esc>"] = custom_actions.close_telescope,
					},
					n = {
						["q"] = actions.close,
						["<C-c>"] = actions.close,
					},
				},

				borderchars = { "─", "│", "─", "│", "┌", "┐", "└", "┘" },
				prompt_prefix = "→ ",
				selection_caret = "▶ ",
				entry_prefix = "● ",
				multi_icon = "☑ ",
			},

			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
					hidden = true,
					find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
				},
				live_grep = {
					theme = "ivy",
					additional_args = function()
						return { "--hidden", "-g", "!.git" }
					end,
				},
				git_commits = {
					theme = "dropdown",
				},
				lsp_document_symbols = {
					theme = "dropdown",
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
						"Variable",
					},
				},
				lsp_workspace_symbols = {
					theme = "dropdown",
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
						"Variable",
					},
				},
			},

			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap
		keymap.set("n", "<C-f>", "<cmd>Telescope find_files<cr>", { desc = "[f]iles" })
		keymap.set("n", "<C-t>", "<cmd>Telescope live_grep<cr>", { desc = "[s]tring" })

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[f]iles" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[s]tring" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope git_commits<cr>", { desc = "[g]it commits" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[b]uffers" })
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "[h]elp tags" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "[c]ommands" })
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "[k]eymaps" })

		-- New symbol search keymaps
		keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "[d]ocument symbols" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "[w]orkspace symbols" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "[r]eferences" })
		keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", { desc = "[i]mplementations" })
	end,
}
