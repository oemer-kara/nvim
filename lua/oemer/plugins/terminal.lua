return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")
		local Terminal = require("toggleterm.terminal").Terminal
		local utils = require("plenary.path")

		local function get_smart_directory()
			local current_buffer_path = vim.fn.expand("%:p")
			if current_buffer_path and current_buffer_path ~= "" then
				return vim.fn.fnamemodify(current_buffer_path, ":p:h")
			end

			-- Final fallback to current working directory
			return vim.fn.getcwd()
		end

		local function detect_terminal_shell()
			local cmder_path = "C:\\tools\\Cmder\\vendor\\init.bat"
			if utils:new(cmder_path):exists() then
				return "cmd.exe /k " .. cmder_path
			end
			return vim.o.shell
		end

		toggleterm.setup({
			-- Cmder shell configuration with fallback
			shell = detect_terminal_shell(),

			-- Intelligent sizing
			size = 15, -- Fixed size of 15 as requested

			direction = "horizontal",

			-- Floating window configuration
			float_opts = {
				border = "rounded",
				width = function()
					return math.floor(vim.o.columns * 0.85)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				winblend = 0,
			},

			-- Terminal behavior
			persist_size = true,
			autochdir = true, -- Ensure `get_smart_directory` is used instead
			close_on_exit = true,

			-- Highlight configurations
			highlights = {
				Normal = { link = "NormalFloat" },
				NormalNC = { link = "NormalFloat" },
				FloatBorder = { guifg = "#565f89" },

				-- New terminal-specific highlights
				TerminalNormal = { bg = "#1a1b26", fg = "#c0caf5" },
				TerminalNormalNC = { bg = "#16161e", fg = "#7aa2f7" },
			},
		})

		-- Create terminal with enhanced keymaps and smart directory detection
		local function create_terminal(opts)
			opts = opts or {}
			return Terminal:new(vim.tbl_deep_extend("force", {
				direction = opts.direction or "float",
				dir = get_smart_directory(), -- Use smart directory detection

				-- Terminal setup
				on_open = function(term)
					vim.cmd("startinsert!")

					-- Consistent terminal keymaps
					local mappings = {
						-- Window navigation
						{ "t", "<C-h>", [[<C-\><C-n><C-w>h]], "Move Left" },
						{ "t", "<C-j>", [[<C-\><C-n><C-w>j]], "Move Down" },
						{ "t", "<C-k>", [[<C-\><C-n><C-w>k]], "Move Up" },
						{ "t", "<C-l>", [[<C-\><C-n><C-w>l]], "Move Right" },

						-- Terminal mode escape
						{ "t", "<Esc>", [[<C-\><C-n>]], "Exit Terminal Mode" },
						{ "t", "<C-q>", [[<C-\><C-n>]], "Quick Exit Terminal Mode" },
					}

					for _, map in ipairs(mappings) do
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							map[1],
							map[2],
							map[3],
							{ noremap = true, silent = true, desc = map[4] }
						)
					end
				end,
			}, opts))
		end

		-- Terminal instances
		local terminals = {
			float = create_terminal({ direction = "float" }),
			horizontal = create_terminal({ direction = "horizontal" }),
			vertical = create_terminal({ direction = "vertical" }),
		}

		-- Keymappings
		local keymap = vim.keymap.set

		-- Add Ctrl+\ shortcut for floating terminal
		keymap({ "n", "t" }, "<C-\\>", function()
			terminals.float:toggle()
		end, { desc = "Toggle Floating Terminal" })

		-- Terminal toggles
		keymap("n", "<leader>tt", function()
			terminals.float:toggle()
		end, { desc = "[t]oggle" })
		keymap("n", "<leader>th", function()
			terminals.horizontal:toggle()
		end, { desc = "[h]orizontal" })
		keymap("n", "<leader>tv", function()
			terminals.vertical:toggle()
		end, { desc = "[v]ertical" })

		-- Terminal management
		keymap("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "[a]ll" })
		keymap("n", "<leader>tl", "<cmd>TermSelect<CR>", { desc = "[l]ist" })

		-- Kill terminal mapping
		keymap("n", "<leader>tk", function()
			local current_term = require("toggleterm.terminal").get(vim.v.count1)
			if current_term then
				current_term:shutdown()
			end
		end, { desc = "[k]ill" })

		-- Terminal workspace selector
		vim.api.nvim_create_user_command("TerminalWorkspace", function()
			vim.ui.select(
				{ "Floating", "Horizontal", "Vertical" },
				{ prompt = "Select Terminal Type" },
				function(choice)
					if choice then
						local term_map = {
							Floating = terminals.float,
							Horizontal = terminals.horizontal,
							Vertical = terminals.vertical,
						}
						term_map[choice]:toggle()
					end
				end
			)
		end, {})
	end,
}
