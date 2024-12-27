return {
	{
		"neovim/nvim-lspconfig",

		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--query-driver=**/mingw64/bin/gcc.exe,**/mingw64/bin/g++.exe",
					"--header-insertion=iwyu",
					"--all-scopes-completion",
					"--suggest-missing-includes",
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
					-- Keybindings for LSP functionality
					local function buf_set_keymap(...)
						vim.api.nvim_buf_set_keymap(bufnr, ...)
					end
					local opts = { noremap = true, silent = true }

					buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
					buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
					buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
					buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
					buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
					buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
					buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				end,
			})
		end,
	},
}
