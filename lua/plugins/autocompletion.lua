return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Set up completion
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded", -- Rounded borders for completion menu
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded", -- Rounded borders for documentation
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					}),
				},
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
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),
				formatting = {
					format = function(entry, vim_item)
						-- Add icons and source names
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]

						-- Highlight the completion item based on your theme
						vim_item.kind = string.format("%s %s", "●", vim_item.kind) -- Add a small dot for visual appeal
						return vim_item
					end,
				},
				experimental = {
					ghost_text = true, -- Show ghost text for better UX
				},
			})

			-- Set up cmdline completion
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})

			-- Custom highlight groups to match your theme
			vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1A1A1A", fg = "#BBBBBB" }) -- Background and text color for the completion menu
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#8B0000", fg = "#FFFFFF" }) -- Selected item in the completion menu
			vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#333333" }) -- Scrollbar background
			vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#777777" }) -- Scrollbar thumb
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#D4A017" }) -- Border color for floating windows
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1A1A1A" }) -- Background for floating windows
		end,
	},
}
