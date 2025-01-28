return {
	"navarasu/onedark.nvim", -- Use the One Dark plugin
	opts = {
		style = "darker", -- Use the darker variant of One Dark
		bold = true,
		invert = {
			signs = false,
			tabline = false,
			visual = false,
		},
		italic = {
			strings = true,
			comments = true,
			operators = false,
			folds = true,
		},
		undercurl = true,
		underline = true,
	},
	config = function()
		require("onedark").setup() -- Initialize One Dark
		vim.cmd.colorscheme("onedark") -- Set the colorscheme
	end,
}
