return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"meuter/lualine-so-fancy.nvim",
	},
	enabled = true,
	lazy = false,
	event = { "BufReadPost", "BufNewFile", "VeryLazy" },
	config = function()
		-- local icons = require("config.icons")
		require("lualine").setup({
			options = {
				theme = "auto",
				-- theme = "github_dark",
				-- theme = "catppuccin",
				globalstatus = true,
				icons_enabled = true,
				-- component_separators = { left = "│", right = "│" },
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"alfa-nvim",
						"help",
						"neo-tree",
						"Trouble",
						"spectre_panel",
						"toggleterm",
					},
					winbar = {},
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"fancy_branch",
				},
				lualine_c = {
					{
						"filename",
						path = 1, -- 2 for full path
						symbols = {
							modified = "  ",
							-- readonly = "  ",
							-- unnamed = "  ",
						},
					},
					{
						"fancy_diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", warn = " ", info = " " },
					},
					{ "fancy_searchcount" },
				},
				lualine_x = {
					"fancy_lsp_servers",
					"fancy_diff",
					"progress",
				},
				lualine_y = { "buffers" },
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				-- lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "neo-tree", "lazy" },
		})
	end,
}

-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	requires = { "nvim-tree/nvim-web-devicons", opt = true },
-- 	config = function()
-- 		-- Lualine setup
-- 		--
-- 		local function clock()
-- 			return os.date("%A, %H:%M")
-- 		end
--
-- 		require("lualine").setup({
-- 			options = {
-- 				theme = "onedark", -- Use the 'onedark' theme for consistency
-- 				component_separators = { left = "", right = "" },
-- 				section_separators = { left = "", right = "" },
-- 				icons_enabled = true, -- Use devicons for a polished look
-- 				globalstatus = true, -- Enables a single statusline across all windows
-- 				disabled_filetypes = {
-- 					statusline = { "packer" }, -- Avoid conflicts with packer
-- 					winbar = {}, -- Ensure all windows, including NvimTree, use the statusline
-- 				},
-- 			},
-- 			sections = {
-- 				lualine_a = { { "mode", fmt = string.upper } }, -- Highlight mode in uppercase
-- 				lualine_b = { "branch", "diff", "diagnostics" },
-- 				lualine_c = { { "filename", path = 1 } }, -- Show full file path
-- 				lualine_x = { "encoding", "fileformat", "filetype" },
-- 				lualine_y = { "buffers" },
-- 				lualine_z = { "location", clock },
-- 			},
-- 			inactive_sections = {
-- 				lualine_a = {},
-- 				lualine_b = {},
-- 				lualine_c = { { "filename", path = 1 } },
-- 				lualine_x = { "location" },
-- 				lualine_y = {},
-- 				lualine_z = {},
-- 			},
-- 			tabline = {},
-- 			extensions = { "fugitive", "quickfix", "nvim-tree" },
-- 		})
-- 	end,
-- }
