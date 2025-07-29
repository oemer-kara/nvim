return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"nvim-telescope/telescope.nvim", -- For enhanced LSP navigation
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		"onsails/lspkind.nvim", -- Adds VS Code-like icons to completion menu
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local telescope = require("telescope.builtin")
		local lspkind = require("lspkind")

		----------------------------------------------------------------------------
		-- LSPKIND CONFIGURATION
		----------------------------------------------------------------------------
		-- Adds VS Code-like icons to the completion menu to improve UX
		lspkind.init({
			mode = "symbol_text", -- Show both symbols and text in completion menu
			preset = "codicons", -- Use codicons icon set (requires patched font)
			symbol_map = {
				Text = "󰉿", -- Text
				Method = "󰆧", -- Method/function call
				Function = "󰊕", -- Function declaration
				Constructor = "󰑐", -- Constructor
				Field = "󰜢", -- Field/property
				Variable = "󰀫", -- Variable
				Class = "󰠱", -- Class
				Interface = "󰜰", -- Interface
				Module = "󰏖", -- Module
				Property = "󰜢", -- Property
				Unit = "󰑭", -- Unit/measurement
				Value = "󰎠", -- Value/constant
				Enum = "󰕘", -- Enumeration
				Keyword = "󰌋", -- Language keyword
				Snippet = "󰘦", -- Code snippet
				Color = "󰏘", -- Color value
				File = "󰈙", -- File path
				Reference = "󰈇", -- Reference
				Folder = "󰉋", -- Directory/folder
				EnumMember = "󰕘", -- Enum member
				Constant = "󰏿", -- Constant value
				Struct = "󰙅", -- Structure
				Event = "󰉁", -- Event
				Operator = "󰆕", -- Operator
				TypeParameter = "󰊄", -- Type parameter
			},
		})

		----------------------------------------------------------------------------
		-- COMPLETION MENU CONFIGURATION
		----------------------------------------------------------------------------
		-- Configure nvim-cmp to show a more compact completion menu
		require("cmp").setup({
			-- Limit number of visible items to prevent overflow
			max_item_count = 5,

			-- Configure appearance of popup windows
			window = {
				-- Main completion popup appearance
				completion = {
					max_width = 40, -- Limit width to 40 columns
					max_height = 5, -- Show max 5 items at once
					border = "rounded", -- Add rounded border for better visibility
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel",
				},
			},

			-- Format completion items using lspkind
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text", -- Show both symbol and text
					maxwidth = 30, -- Max width of item text
					ellipsis_char = "...", -- Use ellipsis for truncated text
					show_labelDetails = true, -- Show additional label details

					-- Custom menu appearance (optional)
					menu = {
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						path = "[Path]",
					},
				}),
			},
		})

		----------------------------------------------------------------------------
		-- CLANGD LSP CONFIGURATION
		----------------------------------------------------------------------------
		-- Configure C/C++ language server
		lspconfig.clangd.setup({
			-- Command line arguments for clangd
			cmd = {
				"clangd",
				"--query-driver=**/mingw64/bin/gcc.exe,**/mingw64/bin/g++.exe", -- Find compilers
				"--header-insertion=never", -- Don't auto-insert headers
				"--all-scopes-completion", -- Complete from all scopes
				"--offset-encoding=utf-16", -- Use UTF-16 encoding
			},

			-- Pass enhanced capabilities from nvim-cmp
			capabilities = capabilities,

			-- Determine the root directory of a project
			root_dir = lspconfig.util.root_pattern(
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac",
				".git"
			),

			-- Set up keymaps when LSP attaches to a buffer
			on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- Navigation
				vim.keymap.set("n", "gd", telescope.lsp_definitions, opts) -- Go to definition
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show hover information
				vim.keymap.set("n", "gi", telescope.lsp_implementations, opts) -- Go to implementation
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Show signature help
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
				vim.keymap.set("n", "gr", telescope.lsp_references, opts) -- Find references
			end,
		})

		-- Python LSP configuration
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gr", telescope.lsp_references, opts)
			end,
		})
	end,
}
