return {
	"slugbyte/lackluster.nvim", -- Use the lackluster.nvim plugin
	lazy = false, -- Ensure the plugin is loaded immediately
	priority = 1000, -- Set a high priority to ensure it loads before other plugins
	opts = {
		-- Tweak the color palette to make it more vibrant
		tweak_color = {
			lack = "#8B0000", -- Dark red (for highlights)
			luster = "#D4A017", -- Muted gold (for accents, complements dark red)
			orange = "#CC5500", -- Burnt orange (less bright)
			yellow = "#D4A017", -- Muted gold
			green = "#556B2F", -- Dark olive green (complements dark red)
			blue = "#1E90FF", -- Dodger blue
			red = "#8B0000", -- Dark red
			black = "#1A1A1A", -- Dark background
			gray1 = "#333333", -- Dark gray
			gray2 = "#555555", -- Medium gray
			gray3 = "#777777", -- Light gray
			gray4 = "#999999", -- Lighter gray
			gray5 = "#BBBBBB", -- Very light gray
		},
		-- Tweak syntax colors for better readability and vibrancy
		tweak_syntax = {
			string = "#D4A017", -- Muted gold for strings (less bright)
			string_escape = "#8B0000", -- Dark red for string escapes
			comment = "#777777", -- Light gray for comments
			builtin = "#1E90FF", -- Dodger blue for built-in functions
			type = "#556B2F", -- Dark olive green for types
			keyword = "#8B0000", -- Dark red for keywords
			keyword_return = "#CC5500", -- Burnt orange for return keywords
			keyword_exception = "#D4A017", -- Muted gold for exceptions
		},
		-- Tweak background transparency and colors
		tweak_background = {
			normal = "#1A1A1A", -- Dark background
			telescope = "#1A1A1A", -- Slightly lighter for Telescope
			menu = "#555555", -- Medium gray for menus
			popup = "#777777", -- Light gray for popups
		},
		-- Tweak UI settings for better visual appeal
		tweak_ui = {
			disable_undercurl = false, -- Keep undercurl for errors/warnings
			enable_end_of_buffer = true, -- Show end-of-buffer symbols
		},
		-- Tweak highlights manually for bold, italic, etc.
		tweak_highlight = {
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
			telescope = false,
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
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#1A1A1A", bg = "#D4A017" })
	end,
}
