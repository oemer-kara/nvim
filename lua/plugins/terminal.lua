return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local CONSTANTS = {
			BUILD_DIR = "C:\\Users\\okara\\Workspace\\Arkasoft\\arkasoft_main\\build",
			EXE_NAME = "kobot_1_0",
			CMDER_PATH = "C:\\tools\\Cmder\\vendor\\init.bat",
		}
		local function file_exists(path)
			local f = io.open(path, "r")
			if f then
				f:close()
				return true
			else
				return false
			end
		end

		local function detect_terminal_shell()
			return file_exists(CONSTANTS.CMDER_PATH) and "cmd.exe /k " .. CONSTANTS.CMDER_PATH or vim.o.shell
		end

		-- Function to parse errors and warnings from terminal buffer
		local function parse_terminal_errors()
			local buffer = vim.api.nvim_get_current_buf()
			local end_line = vim.api.nvim_buf_line_count(buffer)
			local qf_list = {}

			for line_num = 1, end_line do
				local line = vim.api.nvim_buf_get_lines(buffer, line_num - 1, line_num, false)[1] or ""

				if line:find("error:") then
					local entry = {
						filename = "",
						lnum = line_num,
						text = line,
						type = "E",
					}

					local file_pattern = "([A-Za-z]:[^:]+):(%d+)"
					local filename, line_number = line:match(file_pattern)
					if filename and line_number then
						entry.filename = filename
						entry.lnum = tonumber(line_number)
					end

					table.insert(qf_list, entry)
				end
			end

			vim.cmd("cclose")

			if #qf_list > 0 then
				vim.fn.setqflist({}, "r")
				vim.fn.setqflist(qf_list, "r")

				vim.cmd("copen " .. math.min(#qf_list, 20))
				vim.cmd("wincmd p")
				return true
			end
			return false
		end
		local function get_module_name()
			local input = vim.fn.input({
				prompt = "What would you like to build? ([w]in_interface, [k]obot_1_0, [a]rkasoft_common): ",
			})

			local module_map = {
				w = "win_interface",
				k = "kobot_1_0",
				a = "arkasoft_common",
			}

			return module_map[input:lower()]
		end

		local function run_build()
			local Terminal = require("toggleterm.terminal").Terminal
			local build_term = Terminal:new({
				cmd = "cmd.exe /k " .. CONSTANTS.CMDER_PATH,
				direction = "horizontal",
				close_on_exit = false,
			})

			-- Function to check if build is complete
			local function is_build_complete()
				local buffer = vim.api.nvim_buf_get_lines(build_term.bufnr, 0, -1, false)
				for _, line in ipairs(buffer) do
					if line:match("%[BUILD%]%s+took%s+%d+%.?%d*%s+seconds") then
						return true
					end
				end
				return false
			end

			-- Function to handle the build result
			local function handle_build_result()
				if not is_build_complete() then
					-- Check again in 100ms if build isn't complete
					vim.defer_fn(handle_build_result, 100)
					return
				end

				-- Build is complete, check for errors
				if parse_terminal_errors() then
					-- If there are errors, the quickfix list is already populated
					build_term:toggle()
					return
				end

				-- If no errors, prompt to run executable
				vim.ui.input({
					prompt = "Build successful. Run the executable? (y/n): ",
				}, function(input)
					if input and input:lower() == "y" then
						-- Close the horizontal build terminal
						build_term:close()

						-- Create a new vertical terminal for running the executable
						local run_term = Terminal:new({
							cmd = "cmd.exe /k " .. CONSTANTS.CMDER_PATH,
							direction = "vertical",
							size = 20,
							close_on_exit = false,
						})

						-- Position it on the right
						run_term:toggle()
						vim.cmd("wincmd L") -- Move to far right

						-- Run the executable
						run_term:send("cd " .. CONSTANTS.BUILD_DIR)
						run_term:send(CONSTANTS.EXE_NAME .. ".exe")
					else
						build_term:toggle()
					end
				end)
			end

			-- Close any existing terminal
			local existing_term = require("toggleterm.terminal").get(1)
			if existing_term then
				existing_term:close()
			end

			-- Open terminal and run build command
			build_term:toggle()
			build_term:send("cd " .. CONSTANTS.BUILD_DIR)
			build_term:send("cbuild -v build " .. CONSTANTS.EXE_NAME)

			-- Start checking for build completion
			vim.defer_fn(handle_build_result, 100)
		end
		local function run_test()
			local module = get_module_name()
			if not module then
				vim.notify("Invalid module selection", vim.log.levels.ERROR)
				return
			end

			local Terminal = require("toggleterm.terminal").Terminal
			local test_term = Terminal:new({
				cmd = "cmd.exe /k " .. CONSTANTS.CMDER_PATH,
				direction = "vertical",
				size = 20,
				close_on_exit = false,
			})

			-- Function to check if test is complete
			local function is_test_complete()
				local buffer = vim.api.nvim_buf_get_lines(test_term.bufnr, 0, -1, false)
				for _, line in ipairs(buffer) do
					if line:match("%[TEST%]%s+took%s+%d+%.?%d*%s+seconds") then
						return true
					end
				end
				return false
			end

			-- Function to find test failure
			local function find_test_failure()
				local buffer = vim.api.nvim_buf_get_lines(test_term.bufnr, 0, -1, false)
				for _, line in ipairs(buffer) do
					-- Look for the file path and line number in assert failures
					local file_path, line_num = line:match("([^:]+):(%d+) error: Assert statement")
					if file_path and line_num then
						return file_path, line_num
					end
				end
				return nil, nil
			end

			-- Function to handle the test result
			local function handle_test_result()
				if not is_test_complete() then
					-- Check again in 100ms if test isn't complete
					vim.defer_fn(handle_test_result, 100)
					return
				end

				local file_path, line_num = find_test_failure()
				if file_path and line_num then
					-- Ask if user wants to jump to the error location
					vim.ui.input({
						prompt = "Test failed. Jump to error location? (y/n): ",
					}, function(input)
						if input and input:lower() == "y" then
							-- First, focus the leftmost window (where we want the code)
							vim.cmd("wincmd h")

							-- Open the file in the left window
							vim.cmd("edit " .. file_path)
							vim.cmd(":" .. line_num)
							vim.cmd("normal! zz") -- Center the view on the error line

							-- Move terminal to the right if it's not already there
							vim.cmd("wincmd p") -- Go to previous window (terminal)
							vim.cmd("wincmd L") -- Move it to the far right

							-- Focus back on the code window
							vim.cmd("wincmd h")
						end
					end)
				else
					-- If all tests passed, show a message
					vim.notify("All tests passed!", vim.log.levels.INFO)
				end
			end

			-- Close any existing terminal
			local existing_term = require("toggleterm.terminal").get(1)
			if existing_term then
				existing_term:close()
			end

			-- Setup initial layout
			test_term:toggle() -- Open the terminal
			vim.cmd("wincmd L") -- Move terminal to far right
			vim.cmd("wincmd h") -- Focus back to the left window

			-- Run the test command in the terminal
			test_term:send("cd " .. CONSTANTS.BUILD_DIR)
			test_term:send("cbuild -v test " .. module)

			-- Start checking for test completion
			vim.defer_fn(handle_test_result, 100)
		end

		require("toggleterm").setup({
			size = 13,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = detect_terminal_shell(),
			float_opts = {
				border = "curved",
				winblend = 3,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		local Terminal = require("toggleterm.terminal").Terminal
		local terminals = {
			float = Terminal:new({ direction = "float" }),
			horizontal = Terminal:new({ direction = "horizontal" }),
			vertical = Terminal:new({ direction = "vertical" }),
		}

		local mappings = {
			{ "t", "<C-h>", [[<C-\><C-n><C-w>h]], "Move Left" },
			{ "t", "<C-j>", [[<C-\><C-n><C-w>j]], "Move Down" },
			{ "t", "<C-k>", [[<C-\><C-n><C-w>k]], "Move Up" },
			{ "t", "<C-l>", [[<C-\><C-n><C-w>l]], "Move Right" },
			{ "t", "<Esc>", [[<C-\><C-n>]], "Exit Terminal Mode" },
			{
				"n",
				"<leader>tt",
				function()
					terminals.float:toggle()
				end,
				"[t]oggle",
			},
			{
				"n",
				"<leader>th",
				function()
					terminals.horizontal:toggle()
				end,
				"[h]orizontal",
			},
			{
				"n",
				"<leader>tv",
				function()
					terminals.vertical:toggle()
				end,
				"[v]ertical",
			},
			{ "n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", "[a]ll" },
			{ "n", "<leader>tl", "<cmd>TermSelect<CR>", "[l]ist" },
			{ "n", "<leader>te", parse_terminal_errors, "[e]rrors" },
			{ "n", "<C-b>", run_build, "Run Build" },
			{ "n", "<C-n>", run_test, "Run Test" },
			{
				"n",
				"<leader>tk",
				function()
					local current_term = require("toggleterm.terminal").get(vim.v.count1)
					if current_term then
						current_term:shutdown()
					end
				end,
				"[k]ill",
			},
		}

		for _, map in ipairs(mappings) do
			vim.keymap.set(map[1], map[2], map[3], { noremap = true, silent = true, desc = map[4] })
		end
	end,
}