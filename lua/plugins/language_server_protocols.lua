return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"whoissethdaniel/mason-tool-installer.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"nvim-lua/plenary.nvim",
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
		-- MASON CORE SETUP
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
				"clangd", -- C, C++
				-- "java_language_server", -- Java
				"pyre", -- Python
				"cmake", -- CMake
				"texlab", -- LaTeX
			},
		})

		----------------------------------------
		-- TOOL INSTALLER SETUP
		----------------------------------------
		mason_tool_installer.setup({
			ensure_installed = {
				-- Formatters
				"clang-format", -- C, C++
				"black", -- Python
				"google-java-format", -- Java
				"latexindent", -- LaTeX
				-- Linters
				"flake8", -- Python
				-- "cpplint", -- C, C++
			},
		})

		----------------------------------------
		-- NULL-LS SETUP
		----------------------------------------
		null_ls.setup({
			sources = {
				-- FORMATTERS ------------------------
				null_ls.builtins.formatting.clang_format, -- C, C++
				null_ls.builtins.formatting.black, -- Python
				null_ls.builtins.formatting.google_java_format, -- Java
				null_ls.builtins.formatting.latexindent, -- LaTeX

				-- LINTERS ---------------------------
				null_ls.builtins.diagnostics.flake8, -- Python
				-- null_ls.builtins.diagnostics.cpplint, -- C, C++
			},
		})

		----------------------------------------
		-- AUTO FORMATTING
		----------------------------------------
		local format_on_save = function()
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
			})
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = format_on_save,
		})
	end,
}
