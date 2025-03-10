return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-ui-select.nvim", -- Modern UI selector
	},
	config = function()
		----------------------------------------
		-- IMPORTS
		----------------------------------------
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local builtin = require("telescope.builtin")

		----------------------------------------
		-- CUSTOM ACTIONS
		----------------------------------------
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

		----------------------------------------
		-- TELESCOPE SETUP
		----------------------------------------
		telescope.setup({
			defaults = {
				preview = {
					treesitter = true,
					check_mime_type = true,
					timeout = 100, -- Faster preview updates
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-u>"] = custom_actions.preview_scroll_up,
						["<C-d>"] = custom_actions.preview_scroll_down,
						["<C-q>"] = actions.smart_send_to_qflist,
						["<M-h>"] = actions.select_horizontal,
						["<M-v>"] = actions.select_vertical,
						["<C-x>"] = actions.delete_buffer,
						["<Esc>"] = custom_actions.close_telescope,
						["<C-s>"] = actions.toggle_selection + actions.move_selection_next, -- Multi-select
					},
					n = {
						["q"] = actions.close,
						["<C-c>"] = actions.close,
						["<C-s>"] = actions.toggle_selection + actions.move_selection_next, -- Multi-select
					},
				},
				borderchars = { "─", "│", "─", "│", "┐", "└", "┌", "┘" }, -- Clean border characters
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.6,
						results_width = 0.8,
					},
				},
				prompt_prefix = "🔍 ", -- Modern icon
				selection_caret = "➤ ",
				entry_prefix = "  ",
				multi_icon = "✔️ ", -- Modern multi-select icon
				color_devicons = true, -- Colorful icons
				file_ignore_patterns = { "node_modules", ".git" }, -- Ignore unnecessary files
			},

			----------------------------------------
			-- PICKERS CONFIGURATION
			----------------------------------------
			pickers = {
				find_files = {
					theme = "ivy", -- Modern dropdown theme
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
					theme = "cursor", -- Minimalist cursor theme
				},
				lsp_document_symbols = {
					theme = "ivy",
					previewer = false,
					ignore_unnamed_buffers = false,
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
					limit = 1000, -- Increased limit
				},
				lsp_workspace_symbols = {
					theme = "ivy",
					previewer = false,
					ignore_unnamed_buffers = false,
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
					limit = 1000, -- Increased limit
				},
			},

			----------------------------------------
			-- EXTENSIONS
			----------------------------------------
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					theme = "dropdown", -- Modern dropdown for UI select
				},
			},
		})

		----------------------------------------
		-- LOAD EXTENSIONS
		----------------------------------------
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select") -- UI select extension
		telescope.load_extension("live_grep_args")

		----------------------------------------
		-- KEY MAPPINGS
		----------------------------------------
		local keymap = vim.keymap

		-- General keybindings
		keymap.set("n", "<C-f>", "<cmd>Telescope find_files<cr>", { desc = "[f]iles" })
		keymap.set("n", "<C-t>", "<cmd>Telescope live_grep<cr>", { desc = "[s]tring" })
		keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

		-- Symbol search keymaps
		keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "[d]ocument symbols" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "[w]orkspace symbols" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "[r]eferences" })
		keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", { desc = "[i]mplementations" })
	end,
}
