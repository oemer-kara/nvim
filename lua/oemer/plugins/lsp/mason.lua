return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"clangd", -- C and C++ language server
				"cmake", -- CMake language server
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"clang-format", -- C and C++ formatter
				"cpptools", -- C and C++ formatter
				"cpplint", -- C and C++ linter
				"stylua", -- Lua formatter
				"black", -- Python formatter
				"flake8", -- Python linter
				"cmakelint", -- CMake linter
				"jq", -- JSON processor
			},
		})
	end,
}
