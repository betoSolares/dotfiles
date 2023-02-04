local status, go = pcall(require, "go")

if not status then
  return
end

go.setup({
  max_line_len = 100,
  icons = false,
  dap_debug = false,
  luasnip = true,
  lsp_cfg = false,
  lsp_gofumpt = false,
  lsp_keymaps = false,
  lsp_codelens = true,
  lsp_document_formatting = false,
})
