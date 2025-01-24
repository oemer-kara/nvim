return {
	"blazkowolf/gruber-darker.nvim",
	lazy = false, -- Ensure it loads on startup
	priority = 1000, -- Load it before other plugins
	config = function()
		vim.cmd("colorscheme gruber-darker")
	end,
}
