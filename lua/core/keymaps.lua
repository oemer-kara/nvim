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

vim.api.nvim_set_keymap("n", "vv", "V", { noremap = true, silent = true })

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

vim.api.nvim_set_keymap("v", "<Leader>s", ":'<,'>s/\\%V\\<\\><Left><Left><Left>", { noremap = true, silent = false })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Define the function
function VisualBlockSearchReplace()
	-- Get the visual selection range
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	-- Prompt for the search and replace terms
	local search_term = vim.fn.input("Search for: ")
	local replace_term = vim.fn.input("Replace with: ")

	-- Construct the substitute command
	local cmd = string.format("%d,%ds/\\%%V%s/%s/g", start_line, end_line, search_term, replace_term)

	-- Execute the command and check if it worked
	local lines_affected = vim.fn.execute(cmd)
end

-- Map the function to a keybinding (e.g., `<Leader>sr`)
vim.api.nvim_set_keymap("v", "<Leader>sr", ":lua VisualBlockSearchReplace()<CR>", { noremap = true, silent = true })
-- Map the function to a keybinding (e.g., `<Leader>sr`)
vim.api.nvim_set_keymap("v", "<Leader>sr", ":lua VisualBlockSearchReplace()<CR>", { noremap = true, silent = true })

-----------------------------------------------------------
-- File and Buffer Operations
-----------------------------------------------------------
-- Quick save and quit
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>ls", ":ls<CR>", { desc = "List all buffers" })
map("n", "<C-q>", function()
	if vim.bo.buftype == "terminal" then
		vim.cmd("bd!")
	else
		vim.cmd("bd")
	end
end, { desc = "Delete current buffer" })

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
map("n", "]]", "]]zz", { noremap = true, silent = true })
map("n", "[[", "[[zz", { noremap = true, silent = true })

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
	if #qflist == 0 then
		return
	end

	local curr_idx = vim.fn.getqflist({ idx = 0 }).idx
	if curr_idx == #qflist then
		vim.cmd("cfirst")
	else
		vim.cmd("cnext")
	end
end

local function quickfix_prev_or_last()
	local qflist = vim.fn.getqflist()
	if #qflist == 0 then
		return
	end

	local curr_idx = vim.fn.getqflist({ idx = 0 }).idx
	if curr_idx == 1 then
		vim.cmd("clast")
	else
		vim.cmd("cprevious")
	end
end

vim.keymap.set(
	"n",
	"<A-j>",
	quickfix_next_or_first,
	{ desc = "Next quickfix item or wrap to first", noremap = true, silent = true }
)

vim.keymap.set(
	"n",
	"<A-k>",
	quickfix_prev_or_last,
	{ desc = "Previous quickfix item or wrap to last", noremap = true, silent = true }
)

vim.keymap.set("n", "<C-c>", function()
	local chan = vim.b.terminal_job_id
	if chan then
		vim.cmd("startinsert")
		vim.fn.chansend(chan, "\003")
		local ctrlc = vim.api.nvim_replace_termcodes("<C-c>", true, true, true)
		vim.fn.chansend(chan, ctrlc)
		vim.fn.chansend(chan, string.char(3))
	end
end, { noremap = true, silent = true })

vim.keymap.set("i", "<C-h>", "<C-w>", { noremap = true, silent = true })
