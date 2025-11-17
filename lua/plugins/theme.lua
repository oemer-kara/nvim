return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = { bold = true },
      keywordStyle = { bold = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      background = {
        dark = "wave",
        light = "lotus",
      },
    })
    vim.cmd.colorscheme("kanagawa")
  end,
}

-- DARK GRUBER
-- return {
--   {
--     "blazkowolf/gruber-darker.nvim",
--     priority = 1000, -- Ensures the colorscheme loads before other plugins
--     config = function()
--       require("gruber-darker").setup({
--         -- These are the default options, modify as needed
--         bold = true,
--         invert = {
--           signs = false,
--           tabline = false,
--           visual = true, -- Set to true to invert visual selection
--         },
--         italic = {
--           strings = true,
--           comments = true,
--           operators = false,
--           folds = true,
--         },
--         undercurl = true,
--         underline = true,
--       })
--
--       -- Set the colorscheme after configuration
--       vim.cmd.colorscheme("gruber-darker")
--
--       -- Optional: Additional customizations
--       -- Example: Customize line number colors
--       -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#73797e" })
--
--       -- Example: Customize the statusline colors
--       -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "#181818", fg = "#e4e4ef" })
--     end,
--   }
-- }
