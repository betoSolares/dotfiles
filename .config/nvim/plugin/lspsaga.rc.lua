local status, saga = pcall(require, "lspsaga")

if not status then
  return
end

saga.init_lsp_saga({
  server_filetype_map = {},
  border_style = "single",
  move_in_saga = {
    prev = "<S-Tab>",
    next = "<Tab>",
  },
  code_action_lightbulb = {
    enable = false,
  },
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>n", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "<leader>k", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "<leader>gi", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "<leader>r", "<Cmd>Lspsaga rename<CR>", opts)
