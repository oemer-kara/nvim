return {
  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat", -- For dot-repeats (.) to work
    },
    config = function()
      -- First require the module
      local leap = require('leap')

      -- Setup the options
      leap.opts = {
        case_sensitive = false,              -- Case insensitive matching
        safe_labels = "sfnut/SFNLHMUGTZ?",   -- Characters used as labels for immediate targets
        special_keys = {
          repeat_search = '<enter>',
          next_phase_one_target = '<enter>',
          next_target = {'<enter>', ';'},
          prev_target = {'<tab>', ','},
          next_group = '<space>',
          prev_group = '<backspace>',
          multi_accept = '<enter>',
          multi_revert = '<backspace>',
        },
        highlight_unlabeled = true,          -- Highlight unlabeled matches
        auto_jump = false,                   -- Disable auto-jumping to the first match
      }

      -- Define custom mappings for bidirectional jumping with just 's'
      local function leap_bidirectional()
        -- We need to use the leap.leap function directly
        require('leap').leap({
          target_windows = {vim.api.nvim_get_current_win()},
          opts = {
            equivalence_classes = {},  -- This allows both forward and backward search
            auto_jump = false,         -- Disable auto-jumping to first match
          }
        })
      end

      -- Set custom mappings
      vim.keymap.set({'n', 'x', 'o'}, 's', leap_bidirectional, {silent = true, desc = "Leap bidirectional"})

      -- For cross-window jumping
      vim.keymap.set({'n', 'x', 'o'}, 'S', function()
        require('leap').leap({
          target_windows = vim.tbl_filter(
            function(win) return win ~= vim.api.nvim_get_current_win() end,
            vim.api.nvim_tabpage_list_wins(0)
          ),
          opts = {
            auto_jump = false,  -- Disable auto-jumping to first match
          }
        })
      end, {silent = true, desc = "Leap to other windows"})

      -- Additional helpful mappings
      vim.keymap.set({'n', 'x', 'o'}, 'gs', function()
        require('leap').leap({
          target_windows = vim.api.nvim_tabpage_list_wins(0),
          opts = {
            highlight_unlabeled_phase_one_targets = true,
            auto_jump = false,  -- Disable auto-jumping to first match
          }
        })
      end, {silent = true, desc = "Leap in all windows"})
    end,
  }
}
