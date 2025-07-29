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
				"ruff", -- Python
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
				null_ls.builtins.diagnostics.ruff.with({
					extra_args = { "--select=E", "--ignore=F821,F401,F403,F405,F,W,C,N,UP,B,A,COM,C4,DTZ,T10,ISC,G,PIE,T20,PYI,PT,Q,RSE,RET,SLF,SLOT,SIM,TID,TCH,ARG,PTH,ERA,PD,PGH,PL,TRY,NPY,AIR,PERF,FURB,LOG,RUF" }
				}), -- Python
				-- null_ls.builtins.diagnostics.cpplint, -- C, C++
			},
		})

		----------------------------------------
		-- AUTO FORMATTING
		----------------------------------------
		local format_on_save = function()
			vim.lsp.buf.format({ async = false })
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = format_on_save,
		})
	end,
}