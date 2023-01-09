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
vim.keymap.set("", "<C-h>", "<C-w>h", opts)
vim.keymap.set("", "<C-j>", "<C-w>j", opts)
vim.keymap.set("", "<C-k>", "<C-w>k", opts)
vim.keymap.set("", "<C-l>", "<C-w>l", opts)

-- indentation
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)

-- search
vim.keymap.set("n", "<leader><leader>", ":nohlsearch<CR>", opts)
