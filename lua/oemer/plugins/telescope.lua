return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- Custom actions with enhanced functionality
		local custom_actions = transform_mod({
			-- Advanced actions
			smart_send_to_qflist = function(prompt_bufnr)
				local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
				local multi_select = picker:get_multi_selection()

				-- If multi-select, send those; otherwise, send current selection
				local items = #multi_select > 0 and multi_select or { picker:get_selection() }

				actions.send_to_qflist(prompt_bufnr)()
				trouble.open("quickfix")
			end,

			-- Preview scrolling with smoother experience
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

		-- Advanced Telescope setup with modern aesthetics
		telescope.setup({
			defaults = {
				-- Stylish and informative path display
				path_display = {
					"smart",
					shorten = { len = 3, exclude = { -2, -1 } },
				},

				-- Enhanced preview configuration
				preview = {
					treesitter = true,
					check_mime_type = true,
				},

				-- Advanced mapping configuration
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-u>"] = custom_actions.preview_scroll_up,
						["<C-d>"] = custom_actions.preview_scroll_down,
						["<C-q>"] = custom_actions.smart_send_to_qflist,
						["<C-t>"] = trouble_telescope.open,
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

				-- Refined UI elements
				borderchars = { "─", "│", "─", "│", "┌", "┐", "└", "┘" }, -- Solid border with corner and edge characters
				prompt_prefix = "→ ", -- Prompt with an arrow for emphasis
				selection_caret = "▶ ", -- Triangle caret for selection
				entry_prefix = "● ", -- Bullet point for entry prefix
				multi_icon = "☑ ", -- Checkmark icon for multi-selection
			},

			-- Per-picker configurations
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
			},

			-- Extension configurations
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
				},
			},
		})

		-- Load extensions
		telescope.load_extension("fzf")
		telescope.load_extension("todo-comments")
		telescope.load_extension("undo")
		telescope.load_extension("noice")

		-- Keymappings with descriptive help
		local keymap = vim.keymap
		keymap.set("n", "<C-f>", "<cmd>Telescope find_files<cr>", { desc = "[f]iles" })
		keymap.set("n", "<C-t>", "<cmd>Telescope live_grep<cr>", { desc = "[s]tring" })

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[f]iles" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[s]tring" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[t]odos" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope git_commits<cr>", { desc = "[g]it commits" })
		keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "[u]ndo history" })

		-- Buffer and help navigation
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[b]uffers" })
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "[h]elp tags" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "[c]ommands" })
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "[k]eymaps" })

		-- Telescope extensions (requires additional setup)
		keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "[m]arks" })
		keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "[q]uickfix list" })
	end,
}
