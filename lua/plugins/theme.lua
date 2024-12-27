return {
	"blazkowolf/gruber-darker.nvim",
	priority = 1000, -- THis so the colorscheme loads before other plugins
	opts = {
		-- Default configuration with explanatory comments
		bold = true,
		invert = {
			signs = false, -- Don't invert git signs and other signs
			tabline = false, -- Don't invert tabline
			visual = false, -- Don't invert visual selection
		},
		italic = {
			strings = true, -- Italic strings
			comments = true, -- Italic comments
			operators = false, -- No italic operators
			folds = true, -- Italic folds
		},
		undercurl = true, -- Enable undercurl formatting
		underline = true, -- Enable underline formatting
	},
	config = function(_, opts)
		-- Load and configure the colorscheme
		require("gruber-darker").setup(opts)

		-- Set the colorscheme
		vim.cmd.colorscheme("gruber-darker")
	end,
}
