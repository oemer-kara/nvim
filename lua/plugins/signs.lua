return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    floating_window_above_cur_line = false,
      hint_prefix = {
          above = "↙ ",
          current = "← ",
          below = "↖ "
      },
    wrap = false,
    floating_window_off_y = -10,
    handler_opts = {
      border = "double"
    }
  },
}
