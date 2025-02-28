vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "x", '"_x', { desc = "Do things without affecting the registers" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "select all" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "te", ":tabedit<Return>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- move tab
keymap.set("n", "tbh", ":tabmove-<CR>", { desc = "Move a tab to the left" })
keymap.set("n", "tbl", ":tabmove+<CR>", { desc = "Move a tab to the right" })

-- fold
-- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

-- DAP
keymap.set("n", "<F1>", ":lua require'dap'clear_breakpoints()<CR>")
keymap.set("n", "<F2>", ":lua require'dapui'.float_element('scopes', {position = 'center',  enter = true })<CR>")
keymap.set("n", "<F3>", ":lua require'dapui'.float_element('console', {position = 'center'})<CR>")
keymap.set("n", "<F4>", ":lua require'dapui'.toggle()<CR>")
keymap.set("n", "<F5>", ":lua require'dap'.toggle_breakpoint()<CR>")
keymap.set("n", "<F6>", ":lua require'dap'.continue()<CR>")
keymap.set("n", "<F7>", ":lua require'dap'.restart()<CR>")
keymap.set("n", "<F8>", ":lua require'dap'.step_over()<CR>")
keymap.set("n", "<F9>", ":lua require'dap'.step_into()<CR>")
keymap.set("n", "<F10>", ":lua require'dap'.step_out()<CR>")
