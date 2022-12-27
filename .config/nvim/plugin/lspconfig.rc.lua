local status, nvim_lsp = pcall(require, 'lspconfig')

if (not status) then return end

local protocol = require('vim.lsp.protocol')

-- icon for completion
protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- bindings
local bindings = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  buf_set_keymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
end

-- autoformat
local augroup_format = vim.api.nvim_create_augroup('Format', { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

local autoformat = function(client, bufnr)
  bindings(client, bufnr)
  enable_format_on_save(client, bufnr)
end

-- typescript
nvim_lsp.tsserver.setup {
  on_attach = autoformat,
  capabilities = capabilities
}

-- go
nvim_lsp.golangci_lint_ls.setup {
  on_attach = bindings,
  capabilities = capabilities,
  init_options = {
    command = { 'golangci-lint', 'run', '--out-format', 'json' }
  }
}

nvim_lsp.gopls.setup {
  on_attach = bindings,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        shadow = true,
      },
      experimentalPostfixCompletions = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true
    },
  },
}

-- python
nvim_lsp.jedi_language_server.setup {
  on_attach = bindings,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern('.git', 'requirements.txt', '.venv')
}

-- lua config
nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = bindings,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false
      },
    },
  }
}

-- docker
nvim_lsp.dockerls.setup {
  on_attach = autoformat,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern('DockerFile*')
}

-- bash
nvim_lsp.bashls.setup {
  on_attach = autoformat,
  capabilities = capabilities
}

-- json
nvim_lsp.jsonls.setup {
  on_attach = autoformat,
  capabilities = capabilities
}

-- css
nvim_lsp.cssls.setup {
  on_attach = autoformat,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern('package.json', '.git')
}

-- html
nvim_lsp.html.setup {
  on_attach = autoformat,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern('package.json', '.git')
}

-- tailwindcss
nvim_lsp.tailwindcss.setup {
  on_attach = bindings,
  capabilities = capabilities
}

-- diagnostic symbols
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- handle LSP notifications
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = '●' },
  severity_sort = true,
}
)

-- display for erros and wornings
vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = 'always'
  }
})
