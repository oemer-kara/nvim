return {
	"slugbyte/lackluster.nvim", -- Use the lackluster.nvim plugin
	lazy = false, -- Ensure the plugin is loaded immediately
	priority = 1000, -- Set a high priority to ensure it loads before other plugins
	opts = {
		-- Tweak the color palette using your provided colors
		tweak_color = {
			lack = "#8B0000", -- Darker red (for highlights)
			luster = "#FFC43D", -- Vibrant yellow (for accents)
			orange = "#FFC43D", -- Vibrant yellow (used as orange substitute)
			yellow = "#FFC43D", -- Vibrant yellow
			green = "#04724D", -- Dark green (for complementary elements)
			blue = "#05668D", -- Dark blue (for syntax and UI elements)
			red = "#6B242D", -- Darker red
			black = "#1A1A1A", -- Dark background
			gray1 = "#333333", -- Dark gray
			gray2 = "#555555", -- Medium gray
			gray3 = "#9CAFB7", -- Light gray (using your provided color)
			gray4 = "#999999", -- Lighter gray
			gray5 = "#BBBBBB", -- Very light gray
		},
		-- Tweak syntax colors for better readability and vibrancy
		tweak_syntax = {
			string = "#9CAFB7",
			string_escape = "#6B242D",
			comment = "#AABD8C",
			builtin = "#05668D",
			type = "#04724D",
			keyword = "#8B0000",
			keyword_return = "#FFC43D",
			keyword_exception = "#FFC43D",
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
			MiniTablineCurrent = { fg = "#FFC43D", bg = "#1A1A1A", bold = true }, -- Vibrant yellow for current tab
			MiniTablineVisible = { fg = "#05668D", bg = "#1A1A1A" }, -- Dark blue for visible tabs
			MiniTablineHidden = { fg = "#9CAFB7", bg = "#1A1A1A" }, -- Light gray for hidden tabs
			MiniTablineModifiedCurrent = { fg = "#FFC43D", bg = "#1A1A1A" }, -- Vibrant yellow for modified current tab
			MiniTablineModifiedVisible = { fg = "#04724D", bg = "#1A1A1A" }, -- Dark green for modified visible tabs
			MiniTablineModifiedHidden = { fg = "#6B242D", bg = "#1A1A1A" }, -- Darker red for modified hidden tabs
			MiniTablineFill = { bg = "#1A1A1A" }, -- Dark background for unused space
			MiniTablineTabpagesection = { fg = "#FFC43D", bg = "#1A1A1A" }, -- Vibrant yellow for tabpage section

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
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#1A1A1A", bg = "#FFC43D" }) -- Custom cursor color
	end,
}
