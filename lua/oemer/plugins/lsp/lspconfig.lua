return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- Completion for LSP
		{
			"antosha417/nvim-lsp-file-operations", -- File operations with LSP
			config = true,
		},
		"folke/trouble.nvim", -- Diagnostics UI
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap
		local diagnostic = vim.diagnostic

		-- Optimize LSP capabilities for Clang
		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		lspconfig.clangd.setup({
			cmd = {
				"clangd",
				"--query-driver=**/mingw64/bin/gcc.exe,**/mingw64/bin/g++.exe",
				"--header-insertion=iwyu",
				"--all-scopes-completion",
				"--suggest-missing-includes",
				"--clang-tidy",
			},
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern(
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac",
				".git"
			),
			on_init = function(client)
				-- Explicitly set include paths for MinGW
				client.config.settings.init_options = {
					clangdFileStatus = true,
					usePlaceholders = true,
					completeUnimported = true,
					semanticTokens = true,
					compilationDatabaseDirectory = vim.fn.expand("~/"),
					fallbackFlags = {
						"-I" .. vim.fn.expand("C:/ProgramData/mingw64/mingw64/include/c++/13.2.0"),
						"-I" .. vim.fn.expand("C:/ProgramData/mingw64/mingw64/include/c++/13.2.0/x86_64-w64-mingw32"),
						"-I" .. vim.fn.expand("C:/ProgramData/mingw64/mingw64/include/c++/13.2.0/backward"),
						"-I"
							.. vim.fn.expand("C:/ProgramData/mingw64/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/include"),
						"-I" .. vim.fn.expand("C:/ProgramData/mingw64/mingw64/include"),
						"-I" .. vim.fn.expand("C:/ProgramData/mingw64/mingw64/x86_64-w64-mingw32/include"),
					},
				}
			end,
		})

		-- Python configuration
		lspconfig.pyright.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern(".git", "setup.py", "pyproject.toml", "requirements.txt"),
		})

		-- CMake configuration
		lspconfig.cmake.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git"),
		})

		-- Diagnostic configuration
		diagnostic.config({
			virtual_text = { prefix = "●" },
			signs = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Keybindings for LSP actions
		keymap.set("n", "gd", vim.lsp.buf.definition) -- Go to definition
		keymap.set("n", "gD", vim.lsp.buf.declaration) -- Go to declaration
		keymap.set("n", "gi", vim.lsp.buf.implementation) -- Go to implementation

		keymap.set("n", "K", vim.lsp.buf.hover) -- Show hover documentation
		keymap.set("n", "gr", vim.lsp.buf.references) -- Find references

		keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "[r]ename symbol" }) -- Rename symbol
		keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "[c]ode actions" }) -- Code action
	end,
}
