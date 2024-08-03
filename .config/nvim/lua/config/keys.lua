vim.g.mapleader = ","

local opts = { noremap = true, silent = true }

-- scrolling
vim.keymap.set("", "J", "<C-d>zz", opts)
vim.keymap.set("", "K", "<C-u>zz", opts)

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- file saving
vim.keymap.set("c", "W", "w", opts)
vim.keymap.set("c", "Q", "q", opts)
vim.keymap.set("n", "<leader>q", ":qall!<CR>", opts)

-- splits
vim.keymap.set("n", "ss", ":sp<CR>", opts)
vim.keymap.set("n", "sv", ":vsp<CR>", opts)

-- change window
vim.keymap.set("n", "sh", "<C-w>h", opts)
vim.keymap.set("n", "sj", "<C-w>j", opts)
vim.keymap.set("n", "sk", "<C-w>k", opts)
vim.keymap.set("n", "sl", "<C-w>l", opts)

-- move window
vim.keymap.set("n", "<C-h>", "<C-w>H", opts)
vim.keymap.set("n", "<C-j>", "<C-w>J", opts)
vim.keymap.set("n", "<C-k>", "<C-w>K", opts)
vim.keymap.set("n", "<C-l>", "<C-w>L", opts)

-- indentation
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)

-- search
vim.keymap.set("n", "<leader><leader>", ":nohlsearch<CR>", opts)

-- moving on a line
vim.keymap.set("n", "gl", "$", opts)
vim.keymap.set("n", "gh", "0", opts)
