vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- General
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true -- Highlight the current line
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a" -- Enable mouse support
opt.errorbells = false -- Disable error sounds
opt.termguicolors = true -- Enable true color support
opt.background = "dark" -- Dark theme will be chosen if available
opt.signcolumn = "yes" -- Show sign column so that text does not shift
vim.opt.tabstop = 4 -- Number of spaces a tab character represents
vim.opt.shiftwidth = 4 -- Number of spaces used for each step of auto-indentation
vim.opt.showmode = false

-- Performance
opt.lazyredraw = false -- Optimize performance by not redrawing screen during execution
opt.updatetime = 100 -- Faster updates (default: 4000ms)

-- Searching
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Override ignorecase if search contains uppercase
opt.incsearch = true -- Show matches as you type
opt.hlsearch = true -- Highlight search results
opt.wrapscan = true -- Search wraps around the end of the file

-- UI Improvements
opt.scrolloff = 10 -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 10 -- Keep 8 columns visible left/right of cursor
opt.wrap = true -- Disable line wrapping
opt.splitbelow = true -- Horizontal splits below
opt.splitright = true -- Vertical splits to the right
opt.list = false -- Show invisible characters
