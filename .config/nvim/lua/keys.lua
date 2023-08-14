vim.g.mapleader = ","

local opts = { noremap = true, silent = true }

-- scrolling
vim.keymap.set("", "J", "<C-d>", opts)
vim.keymap.set("", "K", "<C-u>", opts)

-- file saving
vim.keymap.set("c", "W", "w", opts)
vim.keymap.set("c", "Q", "q", opts)
vim.keymap.set("n", "<leader>q", ":qall!<CR>", opts)

-- splits
vim.keymap.set("n", "<leader>cs", ":sp<CR>", opts)
vim.keymap.set("n", "<leader>vs", ":vsp<CR>", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-q>h", "<C-w>H", opts)
vim.keymap.set("n", "<C-q>j", "<C-w>J", opts)
vim.keymap.set("n", "<C-q>k", "<C-w>K", opts)
vim.keymap.set("n", "<C-q>l", "<C-w>L", opts)

-- indentation
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)

-- search
vim.keymap.set("n", "<leader><leader>", ":nohlsearch<CR>", opts)

-- moving on a line
vim.keymap.set("n", "gl", "$", opts)
vim.keymap.set("n", "gh", "0", opts)
