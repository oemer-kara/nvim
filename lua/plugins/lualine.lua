return {
	"nvim-lualine/lualine.nvim",

	dependencies = {
		"meuter/lualine-so-fancy.nvim",
		"nvim-tree/nvim-web-devicons", -- Ensure you have this for icons
	},

	enabled = true,
	lazy = false,
	event = { "BufReadPost", "BufNewFile", "VeryLazy" },

	config = function()
		require("lualine").setup({
			options = {
				theme = "auto", -- You can also try "tokyonight", "onedark", or "dracula" for a modern look
				globalstatus = true,
				icons_enabled = true,
				component_separators = { left = "", right = "" }, -- More subtle separators
				section_separators = { left = "", right = "" }, -- Sleek section separators
				disabled_filetypes = {
					statusline = {
						"alfa-nvim",
						"help",
						"neo-tree",
						"Trouble",
						"spectre_panel",
					},
					winbar = {},
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return " " .. str:sub(1, 1) -- Add a cool icon before the mode
						end,
					},
				},
				lualine_b = {
					"fancy_branch",
				},
				lualine_c = {
					{
						"filename",
						path = 1, -- 2 for full path
						fmt = function(str)
							if str:match("toggleterm") then
								return " Terminal" -- Use a terminal icon
							end
							return str
						end,
						symbols = {
							modified = "  ", -- A more modern modified symbol
							readonly = "  ",
							unnamed = "  ",
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
					{
						"filetype",
						icons_enabled = true,
						icon = { align = "right" }, -- Align filetype icon to the right
					},
					{
						"encoding",
						fmt = function(str)
							return " " .. str -- Add a cool icon before encoding
						end,
					},
					{
						"fileformat",
						fmt = function(str)
							return " " .. str -- Add a cool icon before file format
						end,
					},
				},
				lualine_y = {
					{
						"progress",
						fmt = function(str)
							return " " .. str -- Add a cool icon before progress
						end,
					},
				},
				lualine_z = {
					function()
						return " " .. os.date("%d-%m-%Y | %H:%M") -- Add a clock icon before the date and time
					end,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "neo-tree", "lazy" },
		})
	end,
}
