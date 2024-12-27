-----------------------------------------------------------
-- Utility Functions for Keymaps
-----------------------------------------------------------
local function map(mode, lhs, rhs, opts)
	-- Set default options if none provided
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end
-----------------------------------------------------------
-- Essential Navigation
-----------------------------------------------------------
-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resizing
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<C-+>", ":vertical resize =<CR>", { desc = "Equalize window width" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-----------------------------------------------------------
-- File and Buffer Operations
-----------------------------------------------------------
-- Quick save and quit
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>ls", ":ls<CR>", { desc = "List all buffers" })
map("n", "<C-q>", ":bdelete<CR>", { desc = "Delete current buffer" })

-----------------------------------------------------------
-- Editing Enhancements
-----------------------------------------------------------
-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Decrease indent and maintain selection" })
map("v", ">", ">gv", { desc = "Increase indent and maintain selection" })

-- Move lines up and down
--map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
--map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Quick deletion without yanking
map("n", "<leader>d", '"_d', { desc = "Delete without yanking" })
map("v", "<leader>d", '"_d', { desc = "Delete selection without yanking" })
map("v", "<leader>p", '"_dP', { desc = "Paste over selection without yanking" })

-----------------------------------------------------------
-- Split Management
-----------------------------------------------------------
-- Split creation
map("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sc", ":close<CR>", { desc = "Vertical split" })

-----------------------------------------------------------
-- Search and Replace
-----------------------------------------------------------
-- Quick substitute current word
map("n", "<leader>S", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace current word" })

-----------------------------------------------------------
-- Text Objects and Operators
-----------------------------------------------------------
-- Entire buffer operations
map("n", "<leader>ya", "ggVGy", { desc = "Yank entire buffer" })
map("n", "<leader>da", "ggVGd", { desc = "Delete entire buffer" })

-----------------------------------------------------------
-- QuickList
-----------------------------------------------------------

local function quickfix_next_or_first()
	local qflist = vim.fn.getqflist()
	if #qflist == 1 then
		vim.cmd("cfirst")
	else
		vim.cmd("cnext")
	end
end

local function quickfix_prev_or_last()
	local qflist = vim.fn.getqflist()
	if #qflist == 1 then
		vim.cmd("clast")
	else
		vim.cmd("cprevious")
	end
end

vim.keymap.set(
	"n",
	"<A-j>",
	quickfix_next_or_first,
	{ desc = "Next quickfix item or first", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<A-k>",
	quickfix_prev_or_last,
	{ desc = "Previous quickfix item or last", noremap = true, silent = true }
)
