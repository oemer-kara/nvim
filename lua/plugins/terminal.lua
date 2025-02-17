return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")
		local Terminal = require("toggleterm.terminal").Terminal

		-- Path to Cmder's init.bat
		local CMDER_PATH = "C:\\tools\\Cmder\\vendor\\init.bat"

		-- Function to extract file information from error message
		local function parse_error_location(line)
			local path, line_num, col = line:match("([^:]+):(%d+):(%d+): error:")
			if path and line_num and col then
				return {
					filename = path,
					line = tonumber(line_num),
					col = tonumber(col),
				}
			end
			return nil
		end

		-- Modified jump_to_error_location function with robust window handling
		local function jump_to_error_location()
			local line = vim.fn.getline(".")
			local location = parse_error_location(line)

			if location then
				-- Close the terminal first
				vim.cmd("ToggleTerm")

				-- Open or switch to the file
				local bufnr = vim.fn.bufnr(location.filename)
				if bufnr == -1 then
					vim.cmd("e " .. location.filename)
				else
					local win_id = vim.fn.win_findbuf(bufnr)[1]
					if win_id then
						vim.api.nvim_set_current_win(win_id)
					else
						vim.cmd("vsplit")
						vim.api.nvim_win_set_buf(0, bufnr)
					end
				end

				-- Jump to error location
				vim.api.nvim_win_set_cursor(0, { location.line, location.col - 1 })
				vim.cmd("normal! zz")
			end
		end

		-- Function to find first error in terminal buffer
		local function find_first_error(term_buf)
			local lines = vim.api.nvim_buf_get_lines(term_buf, 0, -1, false)
			for i, line in ipairs(lines) do
				if parse_error_location(line) then
					return i
				end
			end
			return nil
		end

		-- Function to position cursor on first error
		local function position_on_first_error(term)
			vim.defer_fn(function()
				local first_error_line = find_first_error(term.bufnr)
				if first_error_line then
					-- Check if the buffer still exists
					if vim.api.nvim_buf_is_valid(term.bufnr) then
						-- Check if there's a window showing this buffer
						local win_id = vim.fn.bufwinid(term.bufnr)
						if win_id ~= -1 then
							-- Move cursor to first error line
							vim.api.nvim_win_set_cursor(win_id, { first_error_line, 0 })
						end
					end
				end
			end, 100)
		end

		-- Terminal instance to reuse
		local terminal_instance = nil

		function _G.create_or_toggle_terminal()
			if terminal_instance then
				-- Close existing terminal if open
				terminal_instance:close()
			end

			-- Create a completely new terminal instance
			terminal_instance = Terminal:new({
				direction = "horizontal",
				shell = "cmd.exe /k " .. CMDER_PATH,
				start_in_insert = true,
				on_stdout = function(term, _, _, _)
					position_on_first_error(term)
				end,
			})

			local term = terminal_instance
			term:toggle()
			term:send("cd /d C:\\Users\\okara\\Workspace\\Arkasoft\\arkasoft_main\\build", false)
			term:send("cbuild -v build kobot_1_0", true)
			term:focus()
		end
		-- Function to get the module name for testing
		local function get_module_name()
			local input = vim.fn.input({
				prompt = "What module would you like to test? ([w]in, [k]obot, [b]ase, [a]ll): ",
			})

			local module_map = {
				w = "win",
				k = "kobot_1_0",
				b = "base",
				a = "all",
			}

			return module_map[input:lower()]
		end

		-- Function to handle the test command
		function _G.run_test()
			local module = get_module_name()
			if not module then
				print("Invalid module selection")
				return
			end

			if terminal_instance then
				-- Close existing terminal if open
				terminal_instance:close()
			end

			-- Create a completely new terminal instance
			terminal_instance = Terminal:new({
				direction = "horizontal",
				shell = "cmd.exe /k " .. CMDER_PATH,
				start_in_insert = false,
				on_stdout = function(term, _, _, _)
					position_on_first_error(term)
				end,
			})

			local test_cmd = module == "all" and "cbuild -v test" or "cbuild -v test " .. module
			local term = terminal_instance

			term:toggle()
			term:send("cd /d C:\\Users\\okara\\Workspace\\Arkasoft\\arkasoft_main\\build", false)
			term:send(test_cmd, true)
			term:focus()
		end
		-- Configure toggleterm with custom settings
		toggleterm.setup({
			direction = "horizontal",
			size = vim.o.columns,
			start_in_insert = true,
			close_on_exit = true,
			auto_scroll = true,
			shell = "cmd.exe /k " .. CMDER_PATH,
			on_create = function(term)
				-- Enable mouse reporting and enter key in terminal
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<CR>", "", {
					noremap = true,
					callback = jump_to_error_location,
				})
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<LeftMouse>", "<LeftMouse>", {
					noremap = true,
					callback = function()
						vim.cmd([[normal! gv]])
						jump_to_error_location()
					end,
				})
			end,
		})

		-- Keybindings for terminal functions
		vim.api.nvim_set_keymap(
			"n",
			"<C-b>",
			"<cmd>lua create_or_toggle_terminal()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"t",
			"<C-b>",
			"<cmd>lua create_or_toggle_terminal()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>lua run_test()<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("t", "<C-n>", "<cmd>lua run_test()<CR>", { noremap = true, silent = true })

		-- Keybindings for toggling the terminal
		vim.api.nvim_set_keymap("n", "<C-\\>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("t", "<C-\\>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })

		-- Keybindings for closing the terminal
		vim.api.nvim_set_keymap(
			"n",
			"<C-q>",
			'<Cmd>lua require("toggleterm.terminal").Terminal:close()<CR><Cmd>bdelete!<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"t",
			"<C-q>",
			'<Cmd>lua require("toggleterm.terminal").Terminal:close()<CR><Cmd>bdelete!<CR>',
			{ noremap = true, silent = true }
		)

		-- Add escape key binding to exit terminal mode
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
	end,
}
