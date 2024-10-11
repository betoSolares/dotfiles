return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      local protocol = require("vim.lsp.protocol")

      protocol.CompletionItemKind = {
        "", -- Text
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

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {}
      )

      require("mason-lspconfig").setup({
        ensure_installed = {
          "astro",
          "bashls",
          "cssls",
          "dockerls",
          "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "tailwindcss",
          "ts_ls",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              capabilities = capabilities,
              root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
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
                    shadow = true,
                  },
                  experimentalPostfixCompletions = true,
                  gofumpt = true,
                  staticcheck = true,
                  usePlaceholders = true,
                  completeUnimported = true,
                },
              },
            })
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
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
          end,
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({
              capabilities = capabilities,
              init_options = {
                preferences = {
                  disableSuggestions = true,
                },
              },
            })
          end,
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      code_action = {
        keys = {
          quit = { "q", "<ESC>" },
        },
      },
      finder = {
        keys = {
          edit = { "i", "o", "<CR>" },
          vsplit = "v",
          split = "s",
          quit = { "q", "<ESC>" },
        },
      },
      lightbulb = {
        sign = true,
        virtual_text = false,
      },
      rename = {
        in_select = false,
        keys = {
          quit = { "q", "<ESC>" },
        },
      },
      ui = {
        theme = "round",
        border = "rounded",
        devicon = true,
        code_action = "󰌵",
      },
    },
    keys = {
      { "<leader>n", ":Lspsaga diagnostic_jump_next<CR>", desc = "Diagnostics jump next" },
      { "<leader>N", ":Lspsaga diagnostic_jump_prev<CR>", desc = "Diagnostics jump prev" },
      { "<leader>k", ":Lspsaga hover_doc<CR>", desc = "Hover documentation" },
      { "<leader>gi", ":Lspsaga finder<CR>", desc = "Go to implementations" },
      { "<leader>r", ":Lspsaga rename<CR>", desc = "Rename" },
      { "<leader>ca", ":Lspsaga code_action<CR>", desc = "Code actions" },
    },
  },
}
