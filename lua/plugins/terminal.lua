return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		-- Constants for paths and configurations
		local CONSTANTS = {
			BUILD_DIR = "C:\\Users\\okara\\Workspace\\Arkasoft\\arkasoft_main\\build",
			EXE_NAME = "kobot_1_0",
			CMDER_PATH = "C:\\tools\\Cmder\\vendor\\init.bat",
		}

		-- Check if a file exists
		local function file_exists(path)
			local f = io.open(path, "r")
			if f then
				f:close()
				return true
			end
			return false
		end

		-- Detect the terminal shell (Cmder or fallback to default)
		local function detect_terminal_shell()
			return file_exists(CONSTANTS.CMDER_PATH) and "cmd.exe /k " .. CONSTANTS.CMDER_PATH or vim.o.shell
		end

		-- Parse terminal errors and populate the quickfix list
		local function parse_terminal_errors()
			local buffer = vim.api.nvim_get_current_buf()
			local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
			local qf_list = {}

			-- Join lines for multi-line error patterns
			local full_text = table.concat(lines, " ")

			-- Error patterns for different formats
			local patterns = {
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

			-- Match patterns and populate the quickfix list
			for _, format in ipairs(patterns) do
				for capture1, capture2, capture3, capture4 in full_text:gmatch(format.pattern) do
					local entry = capture4 and format.handler(capture1, capture2, capture3, capture4)
						or format.handler(capture1, capture2, capture3)
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

		-- Run the build process
		local function run_build()
			vim.cmd("cclose") -- Close any open quickfix window
			local Terminal = require("toggleterm.terminal").Terminal

			-- Find an existing horizontal terminal or create a new one
			local build_term
			for _, term in pairs(require("toggleterm.terminal").get_all()) do
				if term.direction == "horizontal" then
					build_term = term
					break
				end
			end

			build_term = build_term
				or Terminal:new({
					cmd = "cmd.exe /k " .. CONSTANTS.CMDER_PATH,
					direction = "horizontal",
					close_on_exit = false,
				})

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

			-- Handle build result (errors or success)
			local function handle_build_result(term)
				if not is_build_complete(term) then
					vim.defer_fn(function()
						handle_build_result(term)
					end, 100)
					return
				end

				if parse_terminal_errors() then
					return
				end

				-- Prompt to run the executable if build is successful
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
						vim.cmd("wincmd L") -- Move to the far right
						run_term:send("cd " .. CONSTANTS.BUILD_DIR)
						run_term:send(CONSTANTS.EXE_NAME .. ".exe")
					end
				end)
			end

			-- Start the build process
			build_term:toggle()
			build_term:send("cd " .. CONSTANTS.BUILD_DIR)
			build_term:send("cbuild -v build " .. CONSTANTS.EXE_NAME)

			-- Start checking for build completion
			vim.defer_fn(function()
				handle_build_result(build_term)
			end, 100)
		end

		-- Get the module name for testing
		local function get_module_name()
			local input = vim.fn.input({
				prompt = "What module would you like to test? ([w]in_interface, [k]obot_1_0, [b]ase, [a]ll): ",
			})

			local module_map = {
				w = "win_interface",
				k = "kobot_1_0",
				b = "base",
				a = "all",
			}

			return module_map[input:lower()]
		end

		-- Run tests for the selected module
		local function run_test()
			vim.cmd("cclose") -- Close any open quickfix window
			local module = get_module_name()
			if not module then
				vim.notify("Invalid module selection", vim.log.levels.ERROR)
				return
			end

			local Terminal = require("toggleterm.terminal").Terminal

			-- Close any existing terminals
			for _, term in ipairs(require("toggleterm.terminal").get_all()) do
				term:close()
			end

			-- Create a new vertical terminal for testing
			local test_term = Terminal:new({
				cmd = "cmd.exe /k " .. CONSTANTS.CMDER_PATH,
				direction = "vertical",
				size = 20,
				close_on_exit = false,
			})

			-- Function to check if the test is complete
			local function is_test_complete()
				local buffer = vim.api.nvim_buf_get_lines(test_term.bufnr, 0, -1, false)
				for _, line in ipairs(buffer) do
					if line:match("%[TEST%]%s+took%s+%d+%.?%d*%s+seconds") then
						return true
					end
				end
				return false
			end

			-- Handle test results (success or failure)
			local function handle_test_result()
				if not is_test_complete() then
					vim.defer_fn(handle_test_result, 10)
					return
				end

				if parse_terminal_errors() then
					vim.cmd("wincmd h")
					vim.notify("Tests failed!", vim.log.levels.ERROR)
				else
					vim.notify("All tests passed!", vim.log.levels.INFO)
				end
			end

			-- Start the test process
			test_term:toggle()
			vim.cmd("wincmd L") -- Move terminal to the right
			test_term:send("cd " .. CONSTANTS.BUILD_DIR)

			vim.defer_fn(function()
				local test_cmd = module == "all" and "cbuild -v test" or "cbuild -v test " .. module
				test_term:send(test_cmd)
				vim.defer_fn(handle_test_result, 10)
			end, 100)
		end

		-- Setup toggleterm.nvim
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
					border = "FloatBorder", -- Use the FloatBorder highlight group
					background = "NormalFloat", -- Use the NormalFloat highlight group
				},
			},
		})

		-- Custom highlight groups for toggleterm.nvim
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#D4A017", bg = "#1A1A1A" }) -- Gold border
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1A1A1A" }) -- Dark background

		-- Define terminal instances
		local Terminal = require("toggleterm.terminal").Terminal
		local terminals = {
			float = Terminal:new({ direction = "float" }),
			horizontal = Terminal:new({ direction = "horizontal" }),
			vertical = Terminal:new({ direction = "vertical" }),
		}

		-- Function to kill the horizontal terminal
		local function kill_horizontal_terminal()
			local term = terminals.horizontal
			if term:is_open() then
				term:shutdown()
			else
				term:toggle()
			end
		end

		-- Key mappings for terminal operations
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
				kill_horizontal_terminal,
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

		-- Apply key mappings
		for _, map in ipairs(mappings) do
			vim.keymap.set(map[1], map[2], map[3], { noremap = true, silent = true, desc = map[4] })
		end
	end,
}
