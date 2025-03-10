return {
	"rebelot/kanagawa.nvim",
	lazy = false, -- Load the plugin immediately
	priority = 1000, -- Load this plugin before others
	opts = {
		-- Default options
		compile = false, -- Enable compiling the colorscheme
		undercurl = true, -- Enable undercurls
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = true, -- Do not set background color
		dimInactive = false, -- Dim inactive window `:h hl-NormalNC`
		terminalColors = true, -- Define vim.g.terminal_color_{0,17}
		colors = { -- Add/modify theme and palette colors
			palette = {},
			theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
		},
		overrides = function(colors) -- Add/modify highlights
			local theme = colors.theme
			return {
				-- Customize specific highlight groups
				String = { fg = colors.palette.carpYellow, italic = true },
				SomePluginHl = { fg = theme.syn.type, bold = true },

				-- Remove gutter background
				LineNr = { bg = "none" },
				SignColumn = { bg = "none" },
				FoldColumn = { bg = "none" },

				-- Transparent floating windows
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },

				-- Dark completion (popup) menu
				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },

				-- Borderless Telescope
				TelescopeTitle = { fg = theme.ui.special, bold = true },
				TelescopePromptNormal = { bg = theme.ui.bg_p1 },
				TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
				TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
				TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
				TelescopePreviewNormal = { bg = theme.ui.bg_dim },
				TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

				-- Tint background of diagnostic messages
				DiagnosticVirtualTextHint = {
					fg = theme.diag.hint,
					bg = require("kanagawa.lib.color")(theme.diag.hint):blend(theme.ui.bg, 0.95):to_hex(),
				},
				DiagnosticVirtualTextInfo = {
					fg = theme.diag.info,
					bg = require("kanagawa.lib.color")(theme.diag.info):blend(theme.ui.bg, 0.95):to_hex(),
				},
				DiagnosticVirtualTextWarn = {
					fg = theme.diag.warning,
					bg = require("kanagawa.lib.color")(theme.diag.warning):blend(theme.ui.bg, 0.95):to_hex(),
				},
				DiagnosticVirtualTextError = {
					fg = theme.diag.error,
					bg = require("kanagawa.lib.color")(theme.diag.error):blend(theme.ui.bg, 0.95):to_hex(),
				},
			}
		end,
		theme = "wave", -- Load "wave" theme when 'background' option is not set
		background = { -- Map the value of 'background' option to a theme
			dark = "wave", -- Try "dragon" !
			light = "lotus",
		},
	},
	config = function(_, opts)
		require("kanagawa").setup(opts) -- Setup the theme with the provided options
		vim.cmd("colorscheme kanagawa") -- Apply the colorscheme
	end,
}
