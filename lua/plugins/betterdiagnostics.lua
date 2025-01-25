return {
	"sontungexpt/better-diagnostic-virtual-text",
	event = "LspAttach",
	config = function()
		require("better-diagnostic-virtual-text").setup({
			ui = {
				wrap_line_after = false,
				left_kept_space = 3,
				right_kept_space = 3,
				arrow = "  ",
				up_arrow = "  ",
				down_arrow = "  ",
				above = false,
			},
			priority = 2003,
			inline = true,
		})

		vim.diagnostic.config({
			virtual_text = {
				spacing = 4, -- Adjust spacing between virtual text and the line
				prefix = "●", -- Use a bullet symbol as a prefix for virtual text
			},
		})
	end,
}
