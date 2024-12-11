-- Automatically clears the highlights
function AutoClearHighlight()
	-- Set a timer to clear search highlighting after 1 second
	vim.defer_fn(function()
		vim.cmd("nohlsearch")
	end, 3000)
end

-- -- Automatically clears the command line
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			vim.cmd('echo ""')
-- 		end, 1000)
-- 	end,
-- })

-- Create an autocmd to trigger the function after searches
vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = "/",
	callback = AutoClearHighlight,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = "?",
	callback = AutoClearHighlight,
})
-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Automatically remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Reload Neovim config on saving 'init.lua'
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "init.lua",
	command = "source <afile> | PackerCompile",
})

-- Highlight current line only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	callback = function()
		vim.wo.cursorline = true
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	callback = function()
		vim.wo.cursorline = false
	end,
})

-- Automatically enter insert mode in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})
