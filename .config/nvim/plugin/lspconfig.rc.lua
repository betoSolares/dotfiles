local status, nvim_lsp = pcall(require, "lspconfig")

if not status then
  return
end

local protocol = require("vim.lsp.protocol")

protocol.CompletionItemKind = {
  "", -- Text
  "", -- Method
  "", -- Function
  "", -- Constructor
  "", -- Field
  "", -- Variable
  "", -- Class
  "ﰮ", -- Interface
  "", -- Module
  "", -- Property
  "", -- Unit
  "", -- Value
  "", -- Enum
  "", -- Keyword
  "﬌", -- Snippet
  "", -- Color
  "", -- File
  "", -- Reference
  "", -- Folder
  "", -- EnumMember
  "", -- Constant
  "", -- Struct
  "", -- Event
  "ﬦ", -- Operator
  "", -- TypeParameter
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  update_in_insert = true,
  float = {
    source = "always",
  },
})

local bindings = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  buf_set_keymap("i", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
end

nvim_lsp.bashls.setup({
  on_attach = bindings,
  capabilities = capabilities,
  filetypes = { "sh", "bash" },
})

nvim_lsp.cssls.setup({
  on_attach = bindings,
  capabilities = capabilities,
})

nvim_lsp.dockerls.setup({
  on_attach = bindings,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern("DockerFile*"),
})

nvim_lsp.gopls.setup({
  on_attach = bindings,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
        vendor = true,
        regenerate_cgo = true,
        upgrade_dependency = true,
      },
      analyses = {
        unreachable = true,
        nilness = true,
        unusedparams = true,
        useany = true,
        unusedwrite = true,
        ST1003 = true,
        undeclaredname = true,
        fillreturns = true,
        nonewvars = true,
        fieldalignment = false,
        shadow = false,
      },
      experimentalPostfixCompletions = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
})

nvim_lsp.html.setup({
  on_attach = bindings,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern("package.json", ".git"),
})

nvim_lsp.jsonls.setup({
  on_attach = bindings,
  capabilities = capabilities,
})

nvim_lsp.lua_ls.setup({
  capabilities = capabilities,
  on_attach = bindings,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

nvim_lsp.tailwindcss.setup({
  on_attach = bindings,
  capabilities = capabilities,
})

nvim_lsp.tsserver.setup({
  on_attach = bindings,
  capabilities = capabilities,
})
