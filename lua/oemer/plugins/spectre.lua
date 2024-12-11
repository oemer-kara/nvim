return {
	"windwp/nvim-spectre",
	enabled = true,
	event = "BufRead",

	keys = {
		{
			"<leader>Ra",
			function()
				require("spectre").open()
			end,
			desc = "[a]nything anywhere",
		},
		{
			"<leader>Rc",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "[c]urrent word anywhere",
		},
		{
			"<leader>Ro",
			function()
				require("spectre").open_file_search()
			end,
			desc = "[o]nly in current buffer",
		},
	},
}
