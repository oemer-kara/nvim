return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		-- Load snippets from VSCode-style snippet sources
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Modify mapping to allow Enter to work even when suggestions are visible
		local mapping = cmp.mapping.preset.insert({
			["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					-- If a completion item is selected, confirm it
					if cmp.get_active_entry() then
						cmp.confirm({
							select = false, -- Don't auto-select if nothing is selected
							behavior = cmp.ConfirmBehavior.Replace,
						})
					else
						-- If no item is selected, fall back to default Enter behavior
						fallback()
					end
				else
					-- If completion menu is not visible, use default Enter
					fallback()
				end
			end, { "i", "s", "c" }),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
		})

		-- Rest of the configuration remains the same as your original setup
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = mapping,
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "luasnip", priority = 750 },
				{ name = "buffer", priority = 500 },
				{ name = "path", priority = 250 },
			}),
			matching = {
				disallow_partial_fuzzy_matching = true,
			},
			formatting = {
				format = function(entry, vim_item)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})

		-- Search (/) completion setup
		cmp.setup.cmdline("/", {
			mapping = mapping,
			sources = {
				{ name = "buffer" },
			},
		})

		-- Command-line (:) completion setup
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<C-j>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							vim.api.nvim_feedkeys(
								vim.api.nvim_replace_termcodes("<Down>", true, false, true),
								"n",
								false
							)
						end
					end,
				},
				["<C-k>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, false, true), "n", false)
						end
					end,
				},
				["<CR>"] = {
					c = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
				},
			}),
			sources = cmp.config.sources({
				{ name = "path" },
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
	end,
}
