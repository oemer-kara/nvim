return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- Enable the plugin
			mappings = {
				basic = true,
				extra = true,
			},
		},
		config = function()
			-- Set up the plugin
			require("Comment").setup()

			-- Set commentstring for cpp files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "cpp",
				callback = function()
					vim.bo.commentstring = "// %s"
				end,
			})
		end,
	},
}
