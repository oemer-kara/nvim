return {
	"ggandor/leap.nvim",
	config = function()
        require('leap').opts.safe_labels = ''

        -- Simple leap setup - just use 's' to jump anywhere (both directions)
		vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)', {silent = true, desc = "Leap anywhere"})

        vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
        vim.api.nvim_create_autocmd('ColorScheme', {
          group = vim.api.nvim_create_augroup('LeapColorTweaks', {}),
          callback = function ()
            if vim.g.colors_name == 'bad_color_scheme' then
              -- Forces using the defaults: sets `IncSearch` for labels,
              -- `Search` for matches, removes `LeapBackdrop`, and updates the
              -- look of concealed labels.
              require('leap').init_hl(true)
            end
          end
        })
    end,
}
