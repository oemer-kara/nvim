-----------------------------------------------------------
-- Performance Optimizations
-----------------------------------------------------------
vim.opt.lazyredraw = true -- Prevent screen redrawing during macros execution, improving performance
vim.opt.ttyfast = true -- Indicates a fast terminal connection, enables smoother scrolling
vim.opt.synmaxcol = 200 -- Limit syntax highlighting to first 200 columns to improve performance in large files

-----------------------------------------------------------
-- Line Numbers and Display Settings
-----------------------------------------------------------
vim.opt.number = true -- Show absolute line numbers on the left
vim.opt.relativenumber = true -- Show relative line numbers for easier vertical navigation
vim.opt.signcolumn = "yes" -- Always show the sign column to prevent text shifting
vim.opt.cursorline = true -- Highlight the current line for better visibility
-- vim.opt.colorcolumn = "80"     -- Display vertical line at column 80 for code length guidance
vim.opt.shortmess:append("c") -- Reduce completion menu messages for cleaner interface
vim.opt.pumheight = 10 -- Set maximum number of items in popup menu to avoid overwhelming the screen

-----------------------------------------------------------
-- Indentation and Text Formatting
-----------------------------------------------------------
vim.opt.smartindent = true -- Enable smart autoindenting when starting a new line
vim.opt.expandtab = true -- Convert tabs to spaces for consistent formatting
vim.opt.tabstop = 4 -- Set width of tab character to 4 spaces
vim.opt.shiftwidth = 4 -- Set width of indent to 4 spaces
vim.opt.softtabstop = 4 -- Backspace removes 4 spaces at a time if they were added as indentation
vim.opt.breakindent = true -- Maintain indent level when line wrapping occurs

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
-- File Handling and Backup
-----------------------------------------------------------
vim.opt.swapfile = false -- Disable creation of swap files
vim.opt.backup = false -- Disable backup file creation
vim.opt.undofile = true -- Enable persistent undo history between sessions
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Directory for storing undo files
vim.opt.autoread = true -- Automatically reload files changed outside of Neovim
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.fileencoding = "utf-8" -- Set default file encoding to UTF-8

-----------------------------------------------------------
-- Editor Behavior
-----------------------------------------------------------
vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all operations
vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor when scrolling
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible when scrolling horizontally
vim.opt.virtualedit = "block" -- Allow cursor placement beyond text in visual block mode
vim.opt.updatetime = 50 -- Reduce update time for faster response (default: 4000ms)
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence completion
vim.opt.ttimeoutlen = 10 -- Time to wait for key code sequence completion

-----------------------------------------------------------
-- Window Management
-----------------------------------------------------------
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.equalalways = true -- Keep windows equal size when splitting
vim.opt.winminwidth = 10 -- Minimum width for any window
vim.opt.winminheight = 1 -- Minimum height for any window
vim.opt.previewheight = 12 -- Height of preview window
vim.opt.laststatus = 3 -- One lualine

-----------------------------------------------------------
-- Visual Appearance
-----------------------------------------------------------
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.opt.cmdheight = 1 -- Height of command line
vim.opt.wrap = false -- Disable line wrapping
vim.opt.linebreak = true -- Break lines at word boundaries when wrap is enabled
vim.opt.showmode = false -- Don't show mode in command line (shown in statusline)
vim.opt.list = false -- Show invisible characters
vim.opt.listchars = { -- Define how invisible characters are displayed
	tab = "→ ", -- Show tabs as right arrow and space
	trail = "·", -- Show trailing spaces as middle dot
	extends = "»", -- Show » when line continues beyond right
	precedes = "«", -- Show « when line continues beyond left
	nbsp = "␣", -- Show non-breaking space as ␣
	space = "⋅", -- Show spaces as middle dot
	eol = "↴", -- Show end of line character
}

-----------------------------------------------------------
-- Completion Settings
-----------------------------------------------------------
vim.opt.completeopt = "menuone,noselect,noinsert" -- Completion menu behavior
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.wildignore:append({ -- Patterns to ignore during file/directory matching
	"*/node_modules/*", -- Ignore node_modules directories
	"*/dist/*", -- Ignore dist directories
	"*.pyc", -- Ignore Python compiled files
	"*.git/*", -- Ignore Git directories
})

-----------------------------------------------------------
-- History and Session Management
-----------------------------------------------------------
vim.opt.history = 10000 -- Remember more commands and search history
vim.opt.undolevels = 10000 -- Maximum number of changes that can be undone
vim.opt.shada = "!,'1000,<50,s10,h" -- ShaDa file settings for persistent history

-----------------------------------------------------------
-- Diff Mode Settings
-----------------------------------------------------------
vim.opt.diffopt = vim.opt.diffopt -- Configure diff mode behavior
	+ "algorithm:patience" -- Use patience algorithm for better diffs
	+ "indent-heuristic" -- Use indent heuristic for better diffs
	+ "linematch:60" -- Improve line matching up to 60 lines

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
