return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	event = "VeryLazy",
	keys = {
		{ "<C-e>", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("neo-tree").setup({

			popup_border_style = "single",
			auto_clean_after_session_restore = false,
			enable_git_status = true,
			enable_modified_markers = true,
			enable_diagnostics = true,
			sort_case_insensitive = true,

			default_component_configs = {
				indent = {
					with_markers = true,
					with_expanders = true,
				},
				modified = {
					symbol = " ",
					highlight = "NeoTreeModified",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					folder_empty_open = "",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "",
						deleted = "",
						modified = "",
						renamed = "",
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			window = {
				auto_open = false,
				position = "float",
				width = 35,
			},
			filesystem = {
				use_libuv_file_watcher = true,
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"node_modules",
					},
					never_show = {
						".DS_Store",
						"thumbs.db",
					},
				},
			},
			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem", display_name = "   Files " },
					{ source = "buffers", display_name = "   Bufs " },
					{ source = "git_status", display_name = "   Git " },
				},
			},
		})
	end,
}
