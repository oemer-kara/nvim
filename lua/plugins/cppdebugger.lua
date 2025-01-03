-- File: ~/.config/nvim/lua/debug_config.lua

return {
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- DAP UI Setup
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						position = "bottom",
						size = 10,
					},
				},
			})

			-- DAP Adapters Configuration
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}

			-- Select Debug Configuration
			local selected_config
			local function select_debug_config()
				if not selected_config then
					local choice =
						vim.fn.input("[a]rkasoft_common test, [w]in_interface test, [k]obot test, or k[o]bot_1_0: ")
					if not choice:match("[awkoAWKO]") then
						print("Invalid choice. Defaulting to arkasoft_common test.")
						choice = "a"
					end

					local configs = {
						a = {
							name = "tests - arkasoft_common",
							program = vim.fn.getcwd() .. "/build/test_arkasoft_common.exe",
							cwd = vim.fn.getcwd() .. "/tests/arkasoft_common/",
						},
						w = {
							name = "tests - win_interface",
							program = vim.fn.getcwd() .. "/build/test_win_interface.exe",
							cwd = vim.fn.getcwd() .. "/tests/win_interface/",
						},
						k = {
							name = "tests - kobot_1_0",
							program = vim.fn.getcwd() .. "/build/test_kobot_1_0.exe",
							cwd = vim.fn.getcwd() .. "/tests/kobot_1_0/",
						},
						o = {
							name = "kobot_1_0.exe",
							program = vim.fn.getcwd() .. "/build/kobot_1_0.exe",
							cwd = vim.fn.getcwd() .. "/build",
						},
					}
					selected_config = configs[choice:lower()]
				end
				return selected_config
			end

			-- DAP Configurations
			dap.configurations.cpp = {
				{
					type = "gdb",
					request = "launch",
					program = function()
						local config = select_debug_config()
						return config and config.program
					end,
					cwd = function()
						local config = select_debug_config()
						return config and config.cwd
					end,
					stopAtEntry = false, -- Change to false, automatically stops at the first breakpoint
					setupCommands = {
						-- Pretty printing for better debugging
						{
							text = "-enable-pretty-printing",
							description = "Enable pretty printing",
							ignoreFailures = false,
						},
						-- Async mode for smoother execution control
						{ text = "set target-async on", description = "Enable async mode", ignoreFailures = false },
						-- Automatically focus on the main thread at launch
						{
							text = "thread 1",
							description = "Automatically focus on main thread",
							ignoreFailures = false,
						},
						-- Lock scheduler to debug only the current thread unless switched
						{
							text = "set scheduler-locking step",
							description = "Lock scheduler on step",
							ignoreFailures = false,
						},
					},
				},
			}

			-- Automatically Start Debugging
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					dap.continue()
				end,
			})

			-- Keybindings
			vim.keymap.set("n", "<F5>", function()
				print("F5 pressed!")
				dap.continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				print("F10 pressed!")
				dap.step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				print("F11 pressed!")
				dap.step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				print("F12 pressed!")
				dap.step_out()
			end)
			vim.keymap.set("n", "<Leader>b", function()
				print("Breakpoint toggled!")
				dap.toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>dt", function()
				print("DAP UI toggled!")
				dapui.toggle()
			end)

			-- Auto Open/Close UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
