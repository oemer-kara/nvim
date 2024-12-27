-----------------------------------------------------------
-- Autocommands for Enhanced User Experience
-----------------------------------------------------------
vim.cmd([[
    " Restore cursor position when reopening files
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif

    " Briefly highlight yanked text for visual feedback
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}

   " Automatically resize splits when Neovim window is resized
    autocmd VimResized * wincmd =

    " Automatically remove trailing whitespace when saving files
    autocmd BufWritePre * :%s/\s\+$//e

    " Only show cursorline in active window for better focus
    autocmd WinEnter,BufEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
]])
