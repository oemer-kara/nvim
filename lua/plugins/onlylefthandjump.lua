return {
	"mluders/comfy-line-numbers.nvim",
	opts = {
		labels = {
			"1",
			"2",
			"3",
			"4",
			"11",
			"12",
			"13",
			"14",
			"21",
			"22",
			"23",
			"24",
			"31",
			"32",
			"33",
			"34",
			"41",
			"42",
			"43",
			"44",
		},
		up_key = "k",
		down_key = "j",
	},
	config = function(_, opts)
		require("comfy-line-numbers").setup(opts)
		vim.opt.number = true
	end,
}
