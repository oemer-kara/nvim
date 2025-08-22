return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
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

		-- Detect availability of search tools for RHEL-friendly fallbacks
		local has_rg = vim.fn.executable("rg") == 1
		local has_fd = vim.fn.executable("fd") == 1
		local has_git = vim.fn.executable("git") == 1

		-- Determine a file listing command compatible with the current system
		local find_files_cmd
		if has_rg then
			find_files_cmd = { "rg", "--files", "--hidden", "-g", "!.git" }
		elseif has_fd then
			find_files_cmd = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix", "--exclude", ".git" }
		else
			find_files_cmd = { "find", ".", "-type", "f", "-not", "-path", "*/.git/*" }
		end

		-- Check if we're in a git repository
		local function is_git_repo()
			return vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true") ~= nil
		end

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
				-- Use ripgrep when available; fall back to git grep or regular grep
				vimgrep_arguments = has_rg and {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				} or (has_git and is_git_repo()) and {
					"git",
					"grep",
					"--line-number",
					"--column",
					"--no-color",
					"-I",
					"-E",
				} or {
					"grep",
					"-R",
					"-n",
					"--binary-files=without-match",
					"-E",
					"-i",
					"--color=never",
					"--exclude-dir=.git",
					".",
				},
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
					find_command = find_files_cmd,
				},
				live_grep = {
					theme = "ivy",
					additional_args = function()
						if has_rg then
							return { "--hidden", "-g", "!.git" }
						elseif has_git and is_git_repo() then
							return {}
						else
							return {}
						end
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
				["ui-select"] = {
					theme = "dropdown", -- Modern dropdown for UI select
				},
			},
		})

		----------------------------------------
		-- LOAD EXTENSIONS
		----------------------------------------
		telescope.load_extension("ui-select") -- UI select extension
		if has_rg then
			telescope.load_extension("live_grep_args")
		end

		----------------------------------------
		-- KEY MAPPINGS
		----------------------------------------
		local keymap = vim.keymap

		-- General keybindings
		keymap.set("n", "<C-f>", "<cmd>Telescope find_files<cr>", { desc = "[f]iles" })
		keymap.set("n", "<C-t>", function()
			-- Debug: Print what tools we have
			print("Debug: has_rg=" .. tostring(has_rg) .. ", has_git=" .. tostring(has_git))
			if has_git then
				print("Debug: is_git_repo=" .. tostring(is_git_repo()))
			end
			
			-- Try the simplest approach first - just call live_grep without any conditions
			builtin.live_grep({
				prompt_title = "Live Grep (Debug)",
			})
		end, { desc = "Live grep search" })
		if has_rg then
			keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		else
			keymap.set("n", "<leader>fg", function()
				builtin.live_grep()
			end, { desc = "Live grep" })
		end

		-- Symbol search keymaps
		keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "[d]ocument symbols" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "[w]orkspace symbols" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "[r]eferences" })
		keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", { desc = "[i]mplementations" })
	end,
}
