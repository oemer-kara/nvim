return {
	"nvim-neo-tree/neo-tree.nvim",

	-----------------------------------
	-- Branch & Dependencies
	-----------------------------------
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	-----------------------------------
	-- Events & Keybindings
	-----------------------------------
	event = "VeryLazy",
	keys = {
		{ "<C-e>", "<cmd>Neotree toggle float<cr>", silent = true, desc = "Float File Explorer" },
	},

	-----------------------------------
	-- Configuration
	-----------------------------------
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("neo-tree").setup({
			popup_border_style = "rounded",
			auto_clean_after_session_restore = false,
			enable_git_status = true,
			enable_modified_markers = true,
			enable_diagnostics = true,
			sort_case_insensitive = true,

			-----------------------------------
			-- Component Configurations
			-----------------------------------
			default_component_configs = {
				indent = {
					with_markers = true,
					with_expanders = true,
				},
				modified = {
					symbol = "●",
					highlight = "NeoTreeModified",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					folder_empty_open = "",
				},
				git_status = {
					symbols = {
						added = "",
						deleted = "",
						modified = "",
						renamed = "",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},

			-----------------------------------
			-- Window Configurations
			-----------------------------------
			window = {
				auto_open = false,
				position = "float",
				width = 35,
				mappings = {
					["<space>"] = "toggle_node",
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["R"] = "refresh",
					["a"] = "add",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
				},
			},

			-----------------------------------
			-- Filesystem Settings
			-----------------------------------
			filesystem = {
				use_libuv_file_watcher = true,
				follow_current_file = {
					enabled = true,
				},
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = { "node_modules" },
					never_show = { ".DS_Store", "thumbs.db" },
				},
			},

			-----------------------------------
			-- Source Selector
			-----------------------------------
			source_selector = {
				winbar = true,
				statusline = false,
				sources = {
					{ source = "filesystem", display_name = " 󰉓 Files " },
					{ source = "buffers", display_name = " 󰈙 Buffers " },
					{ source = "git_status", display_name = " 󰊢 Git " },
				},
			},

			-----------------------------------
			-- Additional Features
			-----------------------------------
			use_popups_for_input = true,
			close_if_last_window = true,
			buffers = {
				follow_current_file = {
					enabled = true,
				},
			},
		})
	end,
}
