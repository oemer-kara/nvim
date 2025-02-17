return {
	"slugbyte/lackluster.nvim", -- Use the lackluster.nvim plugin
	lazy = false, -- Ensure the plugin is loaded immediately
	priority = 1000, -- Set a high priority to ensure it loads before other plugins
	opts = {
		-- Tweak the color palette using your provided colors
		tweak_color = {
			lack = "#A00000", -- Slightly brighter red (for highlights)
			luster = "#FFD700", -- More vibrant yellow (for accents)
			orange = "#FFA500", -- Actual orange for better distinction
			yellow = "#FFD700", -- More vibrant yellow
			green = "#00A86B", -- Brighter green (for complementary elements)
			blue = "#1E90FF", -- Brighter blue (for syntax and UI elements)
			red = "#8B0000", -- Slightly brighter red
			black = "#1A1A1A", -- Dark background (unchanged)
			gray1 = "#333333", -- Dark gray (unchanged)
			gray2 = "#555555", -- Medium gray (unchanged)
			gray3 = "#9CAFB7", -- Light gray (unchanged)
			gray4 = "#999999", -- Lighter gray (unchanged)
			gray5 = "#BBBBBB", -- Very light gray (unchanged)
		},
		-- Tweak syntax colors for better readability and vibrancy
		tweak_syntax = {
			string = "#9CAFB7", -- Unchanged
			string_escape = "#8B0000", -- Slightly brighter red
			comment = "#AABD8C", -- Unchanged
			builtin = "#1E90FF", -- Brighter blue
			type = "#00A86B", -- Brighter green
			keyword = "#A00000", -- Slightly brighter red
			keyword_return = "#FFD700", -- More vibrant yellow
			keyword_exception = "#FFA500", -- Actual orange
		},
		-- Tweak background transparency and colors
		tweak_background = {},
		-- Tweak UI settings for better visual appeal
		tweak_ui = {
			disable_undercurl = false, -- Keep undercurl for errors/warnings
			enable_end_of_buffer = true, -- Show end-of-buffer symbols
		},
		-- Tweak highlights manually for bold, italic, etc.
		tweak_highlight = {
			-- Add MiniTabline highlights here
			MiniTablineCurrent = { fg = "#FFD700", bg = "#1A1A1A", bold = true }, -- More vibrant yellow for current tab
			MiniTablineVisible = { fg = "#1E90FF", bg = "#1A1A1A" }, -- Brighter blue for visible tabs
			MiniTablineHidden = { fg = "#9CAFB7", bg = "#1A1A1A" }, -- Light gray for hidden tabs
			MiniTablineModifiedCurrent = { fg = "#FFD700", bg = "#1A1A1A" }, -- More vibrant yellow for modified current tab
			MiniTablineModifiedVisible = { fg = "#00A86B", bg = "#1A1A1A" }, -- Brighter green for modified visible tabs
			MiniTablineModifiedHidden = { fg = "#8B0000", bg = "#1A1A1A" }, -- Slightly brighter red for modified hidden tabs
			MiniTablineFill = { bg = "#1A1A1A" }, -- Dark background for unused space
			MiniTablineTabpagesection = { fg = "#FFD700", bg = "#1A1A1A" }, -- More vibrant yellow for tabpage section

			-- Updated highlight groups with darker backgrounds

			-- Existing syntax highlights
			["@keyword"] = {
				overwrite = false,
				bold = true,
				italic = true,
			},
			["@function"] = {
				overwrite = true,
				link = "@keyword", -- Link functions to keywords
			},
			["@string"] = {
				overwrite = false,
				bold = true, -- No bold for strings (softer look)
			},
			["@comment"] = {
				overwrite = false,
				italic = true,
			},
		},
		-- Disable plugin highlights (optional, customize as needed)
		disable_plugin = {
			bufferline = false,
			cmp = false,
			dashboard = false,
			flash = false,
			git_gutter = false,
			git_signs = false,
			headline = false,
			indentmini = false,
			lazy = false,
			lightbulb = false,
			lsp_config = false,
			mason = false,
			mini_diff = false,
			navic = false,
			noice = false,
			notify = false,
			oil = false,
			rainbow_delimiter = false, -- Keep rainbow delimiters for color
			scollbar = false,
			telescope = true,
			todo_comments = false,
			tree = false,
			trouble = false,
			which_key = false,
			yanky = false,
		},
	},
	config = function(_, opts)
		require("lackluster").setup(opts) -- Initialize lackluster with the provided options
		vim.cmd.colorscheme("lackluster") -- Set the colorscheme
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#1A1A1A", bg = "#FFD700" }) -- Custom cursor color with more vibrant yellow
	end,
}
