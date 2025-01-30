return {
	"mluders/comfy-line-numbers.nvim",
	config = function()
		require("comfy-line-numbers").setup({
			labels = {
				"1",
				"2",
				"3",
				"4",
				"5",
				"11",
				"12",
				"13",
				"14",
				"15",
				"21",
				"22",
				"23",
				"24",
				"25",
				"31",
				"32",
				"33",
				"34",
				"35",
				"41",
				"42",
				"43",
				"44",
				"45",
				"51",
				"52",
				"53",
				"54",
				"55",
			},
			up_key = "k", -- Key for moving up
			down_key = "j", -- Key for moving down
			enable_in_terminal = false, -- Disable in terminal buffers
		})
	end,
}
