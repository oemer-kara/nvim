return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			toggler = {
				line = "//", -- Use // for single-line comments
				block = "/*", -- You can adjust block comments if necessary
			},
			opleader = {
				line = "//",
			},
		})
	end,
}
