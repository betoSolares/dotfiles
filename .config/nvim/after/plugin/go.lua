local status, go = pcall(require, 'go')

if (not status) then return end

-- bindings
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', '<leader>t', ':GoToggleInlay<CR>', opts)
end

go.setup({
  max_line_len = 99,
  icons = false,
  dap_debug = false,
  luasnip = true,
  lsp_cfg = true,
  lsp_gofumpt = true,
  lsp_on_attach = on_attach,
  lsp_keymaps = false,
  lsp_codelens = true
})
