return {
	{
		"echasnovski/mini.animate",
		version = false,
		event = "VeryLazy",
		opts = {
			cursor = {
				timing = function(_, n)
					return 150 / n
				end,
			},
			scroll = {
				timing = function(_, n)
					return 150 / n
				end,
			},
			resize = {
				timing = function(_, n)
					return 150 / n
				end,
			},
			open = {
				timing = function(_, n)
					return 150 / n
				end,
			},
			close = {
				timing = function(_, n)
					return 150 / n
				end,
			},
		},
	},
}
