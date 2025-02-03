return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim", -- Modern UI selector
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

				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.6,
						results_width = 0.8,
					},
				},

				-- Custom highlights for a vibrant look
				highlight = {
					prompt = { bg = "#1A1A1A", fg = "#FFC43D" }, -- Using luster color
					results = { bg = "#1A1A1A", fg = "#9CAFB7" }, -- Using gray3
					preview = { bg = "#1A1A1A", fg = "#BBBBBB" }, -- Using gray5
					border = { bg = "#1A1A1A", fg = "#FFC43D" }, -- Using luster color
					cursor = { bg = "#333333", fg = "#FFC43D" }, -- Using gray1 and luster
					selection = { bg = "#333333", fg = "#FFC43D" }, -- Using gray1 and luster
				},

				prompt_prefix = "🔍 ", -- Modern icon
				selection_caret = "❯ ",
				entry_prefix = "  ",
				multi_icon = "✓ ", -- Modern multi-select icon
				color_devicons = true, -- Colorful icons
				file_ignore_patterns = { "node_modules", ".git" }, -- Ignore unnecessary files
			},

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

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select") -- Load UI select extension

		-- Custom highlight groups for Telescope
		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#000000" }) -- Set the main background
		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#000000" }) -- Set prompt background
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#000000" }) -- Set results background
		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#000000" }) -- Set preview background

		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#FFC43D", bg = "#000000" }) -- luster border, black bg
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#FFC43D", bg = "#000000" }) -- luster border, black bg
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#FFC43D", bg = "#000000" }) -- luster border, black bg
		vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#FFC43D", bg = "#000000" }) -- luster prefix, black bg

		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#8B0000", bold = true }) -- lack color for matches
		vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#333333", fg = "#FFC43D" }) -- gray1 and luster

		vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "#FFC43D", fg = "#000000" }) -- luster and black
		vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "#04724D", fg = "#000000" }) -- green and black
		vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "#05668D", fg = "#000000" }) -- blue and black

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
