return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local telescope = require("telescope.builtin")

			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--query-driver=**/mingw64/bin/gcc.exe,**/mingw64/bin/g++.exe",
					"--header-insertion=never",
					"--all-scopes-completion",
					"--offset-encoding=utf-16",
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
	},
}
