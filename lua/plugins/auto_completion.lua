return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"p00f/clangd_extensions.nvim",
		"ray-x/cmp-treesitter",
		"lukas-reineke/cmp-under-comparator",
	},
	config = function()
		----------------------------------------
		-- IMPORTS
		----------------------------------------
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		----------------------------------------
		-- LUASNIP SETUP
		----------------------------------------
		luasnip.config.setup({})

		----------------------------------------
		-- CMP MAIN SETUP
		----------------------------------------
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			----------------------------------------
			-- KEYBINDINGS
			----------------------------------------
			mapping = {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump() -- Jump to the next placeholder in the snippet
					else
						fallback() -- Fallback to default behavior
					end
				end, { "i", "s" }), -- Use in insert and select modes

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1) -- Jump to the previous placeholder in the snippet
					else
						fallback() -- Fallback to default behavior
					end
				end, { "i", "s" }), -- Use in insert and select modes

				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),

				["<C-Space>"] = cmp.mapping.complete(),

				["<C-e>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.abort() -- Close the completion window
					else
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true) -- Send <Esc> if completion window is not visible
					end
				end),

				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
			},

			----------------------------------------
			-- COMPLETION SOURCES
			----------------------------------------
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "treesitter" },
			},

			----------------------------------------
			-- SORTING
			----------------------------------------
			sorting = {
				comparators = {
					require("cmp-under-comparator").under,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.kind,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},

			experimental = { ghost_text = false },
		})

		----------------------------------------
		-- CMDLINE COMPLETION
		----------------------------------------
		cmp.setup.cmdline(":", {
			sources = { { name = "cmdline" }, { name = "path" } },
		})
	end,
}
