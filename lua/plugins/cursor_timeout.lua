return {
	"yamatsum/nvim-cursorline",
	config = function()
		----------------------------------------
		-- CURSORLINE SETUP
		----------------------------------------
		require("nvim-cursorline").setup({
			cursorline = {
				enable = true,
				timeout = 1000,
			},
		})
	end,
}
