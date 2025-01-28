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

		local function parse_terminal_errors()
			local buffer = vim.api.nvim_get_current_buf()
			local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
			local qf_list = {}

			-- Join lines that might be broken in the middle
			local full_text = table.concat(lines, " ")

			-- Patterns for different error formats
			local patterns = {
				-- Format: filepath:line error: message
				{
					pattern = "([^:]+):(%d+)%s+error:%s*(.+)",
					handler = function(filepath, lnum, msg)
						return {
							filename = filepath:gsub("%s+", ""),
							lnum = tonumber(lnum),
							text = msg:gsub("^%s*(.-)%s*$", "%1"),
							type = "E",
						}
					end,
				},
				-- Format: filepath:line:col: error: message
				{
					pattern = "(%g+):(%d+):(%d+): error: (.+)",
					handler = function(filepath, lnum, col, msg)
						return {
							filename = filepath:gsub("%s+", ""),
							lnum = tonumber(lnum),
							col = tonumber(col),
							text = msg:gsub("^%s*(.-)%s*$", "%1"),
							type = "E",
						}
					end,
				},
			}

			-- Try each pattern
			for _, format in ipairs(patterns) do
				for capture1, capture2, capture3, capture4 in full_text:gmatch(format.pattern) do
					local entry
					if capture4 then -- It's the second pattern with 4 captures
						entry = format.handler(capture1, capture2, capture3, capture4)
					else -- It's the first pattern with 3 captures
						entry = format.handler(capture1, capture2, capture3)
					end
					table.insert(qf_list, entry)
				end
			end

			if #qf_list > 0 then
				vim.fn.setqflist(qf_list, "r")
				vim.cmd("copen " .. math.min(#qf_list, 20))
				vim.cmd("wincmd p")
				return true
			end
			return false
		end

		local function run_build()
			vim.cmd("cclose")
			local Terminal = require("toggleterm.terminal").Terminal

			-- Check if there is an existing horizontal terminal
			local existing_term
			for _, term in pairs(require("toggleterm.terminal").get_all()) do
				if term.direction == "horizontal" then
					existing_term = term
					break
				end
			end

			-- Function to check if the build is complete
			local function is_build_complete(term)
				local buffer = vim.api.nvim_buf_get_lines(term.bufnr, 0, -1, false)
				for _, line in ipairs(buffer) do
					if line:match("%[BUILD%]%s+took%s+%d+%.?%d*%s+seconds") then
						return true
					end
				end
				return false
			end

			-- Function to handle the build result
			local function handle_build_result(term)
				if not is_build_complete(term) then
					vim.defer_fn(function()
						handle_build_result(term)
					end, 100)
					return
				end

				-- Build is complete, check for errors
				if parse_terminal_errors() then
					return
				end

				-- If no errors, prompt to run the executable
				vim.ui.input({
					prompt = "Build successful. Run the executable? (y/n): ",
				}, function(input)
					if input and input:lower() == "y" then
						term:shutdown()

						-- Create a new vertical terminal for running the executable
						local run_term = Terminal:new({
							cmd = "cmd.exe /k " .. CONSTANTS.CMDER_PATH,
							direction = "vertical",
							size = 20,
						})

						run_term:toggle()
						vim.cmd("wincmd L") -- Move to far right
						run_term:send("cd " .. CONSTANTS.BUILD_DIR)
						run_term:send(CONSTANTS.EXE_NAME .. ".exe")
					else
					end
				end)
			end

			-- Use the existing terminal or create a new one
			local build_term = existing_term
				or Terminal:new({
					cmd = "cmd.exe /k " .. CONSTANTS.CMDER_PATH,
					direction = "horizontal",
					close_on_exit = false,
				})

			-- If the terminal already exists, toggle and send the build commands
			build_term:toggle()
			build_term:send("cd " .. CONSTANTS.BUILD_DIR)
			build_term:send("cbuild -v build " .. CONSTANTS.EXE_NAME)

			-- Start checking for build completion
			vim.defer_fn(function()
				handle_build_result(build_term)
			end, 100)
		end

		local function get_module_name()
			local input = vim.fn.input({
				prompt = "What module would you like to test? --> ([w]in_interface, [k]obot_1_0, [b]ase, [a]ll): ",
			})

			local module_map = {
				w = "win_interface",
				k = "kobot_1_0",
				b = "base",
				a = "all",
			}

			return module_map[input:lower()]
		end

		local function run_test()
			vim.cmd("cclose")
			local module = get_module_name()
			if not module then
				vim.notify("Invalid module selection", vim.log.levels.ERROR)
				return
			end

			local Terminal = require("toggleterm.terminal").Terminal
			-- Close any existing terminal
			local existing_term = require("toggleterm.terminal").get_all()
			for _, term in ipairs(existing_term) do -- Fixed syntax error in for loop
				term:close()
			end

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

			-- Define handle_test_result before it's used
			local function handle_test_result()
				if not is_test_complete() then
					vim.defer_fn(handle_test_result, 10)
					return
				end

				if parse_terminal_errors() then
					vim.cmd("wincmd h")
					vim.notify("Tests failed!", vim.log.levels.ERROR) -- Changed success message to error since parse_terminal_errors returns true when there are errors
				else
					vim.notify("All tests passed!", vim.log.levels.INFO)
				end
			end

			-- Open new terminal and set up layout
			test_term:toggle()

			-- Make sure terminal is properly initialized before sending commands
			vim.defer_fn(function()
				-- Move terminal to the right
				vim.cmd("wincmd L")
				-- Send commands to terminal
				test_term:send("cd " .. CONSTANTS.BUILD_DIR)
				vim.defer_fn(function()
					-- Check if module is "all" and adjust command accordingly
					local test_cmd = module == "all" and "cbuild -v test" or "cbuild -v test " .. module
					test_term:send(test_cmd)
					-- Start checking for completion after sending the command
					vim.defer_fn(handle_test_result, 10)
				end, 100)
			end, 100)
		end
		require("toggleterm").setup({
			size = 13,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = false,
			shading_factor = 0,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = false,
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
				"t",
				"<C-q>",
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
