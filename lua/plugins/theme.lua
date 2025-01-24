return {
	"navarasu/onedark.nvim",
	lazy = false, -- Ensure it loads on startup
	priority = 1000, -- Load it before other plugins
	config = function()
		require("onedark").setup({
			style = "darker", -- Choose from 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
			transparent = false, -- Enable transparent background
			term_colors = true, -- Configure terminal colors
			ending_tildes = false, -- Show end-of-buffer tildes

			-- Customize highlights
			highlights = {
				-- You can override specific highlight groups here
				-- Example: ["@variable"] = {fg = "$red"}
			},
		})
		require("onedark").load()
	end,
}
