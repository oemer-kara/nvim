return {
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			-- Icon configuration for key mappings
			icons = {
				-- Automatically set icons based on Nerd Font availability
				mappings = vim.g.have_nerd_font,

				-- Custom key icons (only if not using Nerd Font)
				keys = not vim.g.have_nerd_font
						and {
							Up = "↑ ",
							Down = "↓ ",
							Left = "← ",
							Right = "→ ",
							C = "Ctrl ",
							M = "Alt ",
							D = "Cmd ",
							S = "Shift ",
							CR = "Enter ",
							Esc = "Esc ",
							ScrollWheelDown = "↧ ",
							ScrollWheelUp = "↥ ",
							NL = "NL ",
							BS = "Backspace ",
							Space = "Space ",
							Tab = "Tab ",
							-- Function keys
							F1 = "F1",
							F2 = "F2",
							F3 = "F3",
							F4 = "F4",
							F5 = "F5",
							F6 = "F6",
							F7 = "F7",
							F8 = "F8",
							F9 = "F9",
							F10 = "F10",
							F11 = "F11",
							F12 = "F12",
						}
					or {},
			},

			-- Optional plugin configurations
			plugins = {
				marks = true, -- Show marks
				registers = true, -- Show registers
			},

			-- Documented key chains for better organization
			spec = {
				mode = { "n" }, -- NORMAL and VISUAL mode
				-- Group definitions with descriptive names
				{ "<leader>e", group = "[e]xplorer", mode = { "n" } },
				{ "<leader>b", group = "[b]uffers", mode = { "n" } },
				{ "<leader>s", group = "[s]plit", mode = { "n" } },
				{ "<leader>f", group = "[f]ind", mode = { "n" } },
				{ "<leader>w", group = "[w]orkspace", mode = { "n" } },
				{ "<leader>t", group = "[t]erminal", mode = { "n" } },
				{ "<leader>d", group = "[d]iagnostics", mode = { "n" } },
				{ "<leader>l", group = "[l]sp", mode = { "n" } },
				{ "<leader>R", group = "[R]eplace", mode = { "n" } },
			},
		},
		config = function(_, opts)
			-- Load Which-Key with the specified options
			require("which-key").setup(opts)
		end,
	},
}
