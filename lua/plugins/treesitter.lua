return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "cpp", "cmake", "python", "java" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true, -- optional
				},
				indent = {
					enable = false, -- Enable Tree-sitter based indentation
				},
				autotag = {
					enable = true, -- Enable auto-close and auto-renaming of tags
				},
				fold = {
					enable = true, -- Enable folding based on Treesitter
				},
				matchparen = {
					enable = false, -- Disable matching parentheses highlighting
				},
			})

			-- Folding settings
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

			-- Disables the extra column display on folds
			vim.opt.foldcolumn = "0"

			-- This makes that the first line of the fold will be syntax highlighted,
			-- rather than all be one colour.
			vim.opt.foldtext = ""

			-- The levels of folds that are open (not folded) by default.
			-- Set this to a high number to disable auto-folding
			vim.opt.foldlevel = 999
			vim.opt.foldlevelstart = 999
		end,
	},
}
