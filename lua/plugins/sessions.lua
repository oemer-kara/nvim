vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
return {
	"rmagatti/auto-session",

	-----------------------------------
	-- Configuration
	-----------------------------------
	config = function()
		require("auto-session").setup({
			log_level = "info",
			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads" },
			auto_session_enable_last_session = true,
			auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
			auto_session_enabled = true,
			auto_save_enabled = true,
			auto_restore_enabled = true,
		})
	end,
}
