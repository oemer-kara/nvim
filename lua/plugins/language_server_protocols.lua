return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"whoissethdaniel/mason-tool-installer.nvim",
		"jose-elias-alvarez/null-ls.nvim", -- plugin for integrating with formatters and linters
		"nvim-lua/plenary.nvim", -- dependency for null-ls.nvim
	},
	config = function()
		----------------------------------------
		-- IMPORTS
		----------------------------------------
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local null_ls = require("null-ls")

		----------------------------------------
		-- MASON SETUP
		----------------------------------------
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		----------------------------------------
		-- LSP SETUP
		----------------------------------------
		mason_lspconfig.setup({
			ensure_installed = {
				"clangd", -- c, c++
				"pyright", -- python
				"jdtls", -- java
				"ts_ls", -- javascript, typescript
				"cmake", -- cmake
			},
		})

		----------------------------------------
		-- TOOLS SETUP
		----------------------------------------
		mason_tool_installer.setup({
			ensure_installed = {
				"clang-format", -- c and c++ formatter
				--"ast-grep",
				--"cpptools",    -- c and c++ formatter
				"cpplint", -- c and c++ linter
				"stylua", -- lua formatter
				"black", -- python formatter
				"flake8", -- python linter
				"jq", -- json processor
			},
		})

		----------------------------------------
		-- FORMATTERS & LINTERS
		----------------------------------------
		null_ls.setup({
			sources = {
				-- Formatters
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.rustfmt,

				-- Linters
				--null_ls.builtins.diagnostics.cpplint,
				null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.diagnostics.jsonlint,
			},
		})

		----------------------------------------
		-- AUTO FORMATTING
		----------------------------------------
		-- function to format on save
		local format_on_save = function()
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
			})
		end

		-- auto format on save
		vim.api.nvim_create_autocmd("bufwritepre", {
			pattern = "*",
			callback = format_on_save,
		})
	end,
}
