local status, saga = pcall(require, "lspsaga")

if not status then
  return
end

saga.setup({
  finder = {
    edit = { "i", "o", "<CR>" },
    vsplit = "v",
    split = "c",
    quit = { "q", "<ESC>" },
  },
  lightbulb = {
    enable = false,
  },
  symbol_in_winbar = {
    enable = false,
  },
  ui = {
    theme = "round",
    border = "rounded",
    devicon = true,
    code_action = "󰌵",
  },
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "<leader>n", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "<leader>k", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "<leader>gi", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "<leader>r", "<Cmd>Lspsaga rename<CR>", opts)
