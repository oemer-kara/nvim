return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		local notify = require("notify")
		notify.setup({
			stages = "fade",
			timeout = 3000,
			max_width = 60,
			render = "compact",
		})
		vim.notify = notify
	end,
}
