return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")

		local function try_find(path)
			if vim.fn.filereadable(path) == 1 then
				return path
			end
			local alt = vim.fn.expand(path)
			if vim.fn.filereadable(alt) == 1 then
				return alt
			end
			local joined = vim.fn.getcwd() .. "/" .. path
			if vim.fn.filereadable(joined) == 1 then
				return joined
			end
		end

		local function parse_error_line(line)
			if not line then
				return
			end

			local patterns = {
				"([%w]:\\[^%(]+)%((%d+),?(%d*)%)", -- Windows like C:\path\file.cpp(123,45)
				"([^:%s%(]+):(%d+):(%d+)",        -- Unix like src/file.cpp:123:45
				"([^%(]+)%((%d+),?(%d*)%)",        -- Generic path(line,col)
			}
			for _, pat in ipairs(patterns) do
				local f, ln, col = line:match(pat)
				if f and ln then
					return f, tonumber(ln), tonumber(col) or 1
				end
			end
		end

		local function open_target(file, line_num, col_num, open_cmd)
			local target = try_find(file)
			if not target then
				vim.notify("File does not exist: " .. file, vim.log.levels.ERROR)
				return true
			end

			local cmd = open_cmd or "edit"
			vim.cmd(string.format("%s +%d %s", cmd, line_num or 1, vim.fn.fnameescape(target)))
			-- Always place the cursor on the parsed column (defaults to col 1)
			vim.fn.cursor(line_num or 1, (col_num and col_num > 0) and col_num or 1)
			return true
		end

		local function jump_to_first_error_line()
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			for idx, l in ipairs(lines) do
				local file, line_num, col = parse_error_line(l)
				if file then
					vim.cmd.stopinsert()
					vim.api.nvim_win_set_cursor(0, { idx, (col and col > 0) and col or 1 })
					return true
				end
			end
			vim.notify("No file/line found in buffer", vim.log.levels.WARN)
			return false
		end

		local function open_error_from_line(line, open_cmd)
			local file, line_num, col_num = parse_error_line(line)
			if not file then
				return false
			end

			return open_target(file, line_num, col_num, open_cmd)
		end

		local function open_error_from_terminal()
			local row = vim.api.nvim_win_get_cursor(0)[1]
			local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
			local file, line_num, col_num = parse_error_line(line)
			if not file then
				vim.notify("No file/line found in terminal line", vim.log.levels.WARN)
				return
			end
			vim.cmd.stopinsert()
			vim.cmd("ToggleTerm")
			return open_target(file, line_num, col_num, "edit")
		end

		local shell = vim.o.shell
		if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
			shell = "pwsh"
		end

		toggleterm.setup({
			shell = shell,
			direction = "float",
			size = 80,
			start_in_insert = true,
			close_on_exit = true,
			auto_scroll = true,
		})

		-- Basic keybindings for terminal
		-- Toggle terminal
		vim.api.nvim_set_keymap("n", "<C-\\>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("t", "<C-\\>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("t", "<C-q>",  "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })

		local function jump_to_error()
			if vim.bo.buftype == "terminal" then
				return open_error_from_terminal()
			end

			local line = vim.api.nvim_get_current_line()
			if not open_error_from_line(line) then
				vim.notify("No file/line found in this line", vim.log.levels.WARN)
			end
		end

		vim.keymap.set({ "n", "t" }, "E", jump_to_first_error_line, { noremap = true, silent = true, desc = "Jump to first error line" })
		vim.keymap.set("n", "<CR>", jump_to_error, { noremap = true, silent = true, desc = "Jump from error line (Enter)" })
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
	end,
}
