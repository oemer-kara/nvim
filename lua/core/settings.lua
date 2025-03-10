-----------------------------------------------------------
-- Performance Optimizations
-----------------------------------------------------------
vim.opt.synmaxcol = 200 -- Limit syntax highlighting to first 200 columns to improve performance in large files

-----------------------------------------------------------
-- Line Numbers and Display Settings
-----------------------------------------------------------
vim.opt.number = true -- Show absolute line numbers on the left
vim.opt.relativenumber = true -- Show relative line numbers for easier vertical navigation
vim.opt.cursorline = true -- Highlight the current line for better visibility
-- vim.opt.colorcolumn = "80"     -- Display vertical line at column 80 for code length guidance

-----------------------------------------------------------
-- Search and Replace Behavior
-----------------------------------------------------------
vim.opt.ignorecase = true -- Make searches case-insensitive by default
vim.opt.smartcase = true -- Override ignorecase if search pattern contains uppercase
vim.opt.incsearch = true -- Show search matches as you type
vim.opt.hlsearch = false -- Don't highlight all matches after search is complete
vim.opt.gdefault = true -- Apply substitutions globally on lines by default
vim.opt.inccommand = "nosplit" -- Show preview of substitutions in real-time

-----------------------------------------------------------
-- Editor Behavior
-----------------------------------------------------------
vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all operations
vim.opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor when scrolling
vim.opt.sidescrolloff = 8 -- Keep 10 columns visible when scrolling horizontally
vim.opt.virtualedit = "block" -- Allow cursor placement beyond text in visual block mode

-----------------------------------------------------------
-- Window Management
-----------------------------------------------------------
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.equalalways = true -- Keep windows equal size when splitting

-----------------------------------------------------------
-- History and Session Management
-----------------------------------------------------------
vim.opt.history = 10000 -- Remember more commands and search history
vim.opt.undolevels = 10000 -- Maximum number of changes that can be undone

-----------------------------------------------------------
-- Global Leader Key Settings
-----------------------------------------------------------
vim.g.mapleader = " " -- Set Space as the leader key for custom mappings
vim.g.maplocalleader = "," -- Set comma as the local leader for filetype-specific mappings

-----------------------------------------------------------
-- Disable File Explorer
-----------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
