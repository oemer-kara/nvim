return {
	"ggandor/leap.nvim",
	config = function()
		-- Simple leap setup - just use 's' to jump anywhere
		vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)', {silent = true, desc = "Leap forward"})
		vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)', {silent = true, desc = "Leap backward"})
	end,
}
