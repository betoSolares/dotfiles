return {
  {
    "ludovicchabant/vim-gutentags",
    init = function()
      vim.g.gutentags_file_list_command = "fd --type f --hidden --exclude **/.git/"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "lukas-reineke/cmp-under-comparator",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local lspkind = require("lspkind")
      require("lspkind").init({
        mode = "symbol",
        symbol_map = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "塞",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      })

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local comparator = require("cmp-under-comparator")

      local has_words_before = function()
        ---@diagnostic disable-next-line: deprecated
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            comparator.under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                local bufs = {}

                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end

                return vim.tbl_keys(bufs)
              end,
            },
          },
        }),
        formatting = {
          format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mfussenegger/nvim-lint",
      "mhartington/formatter.nvim",
    },
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "shellcheck",
          "stylelint",
          "hadolint",
          "golangci-lint",
          "djlint",
          "eslint_d",
          "luacheck",
          "shfmt",
          "prettierd",
          "golines",
          "gofumpt",
          "stylua",
          "cbfmt",
        },
      })

      local luacheck = require("lint").linters.luacheck
      luacheck.args = {
        "--formatter",
        "plain",
        "--globals",
        "vim",
        "awesome",
        "client",
        "root",
        "mouse",
        "RC",
        "--codes",
        "--ranges",
        "-",
      }

      require("lint").linters_by_ft = {
        bash = { "shellcheck" },
        css = { "stylelint" },
        dockerfile = { "hadolint" },
        go = { "golangcilint" },
        html = { "djlint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        lua = { "luacheck" },
        sh = { "shellcheck" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lintGroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lintGroup,
        callback = function()
          require("lint").try_lint()
        end,
      })

      local utils = require("formatter.util")

      ---@diagnostic disable-next-line: undefined-field
      require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          bash = {
            function()
              return {
                exe = "shfmt",
                args = {
                  "--filename",
                  utils.escape_path(utils.get_current_buffer_file_path()),
                  "-",
                },
                stdin = true,
              }
            end,
          },
          css = {
            function()
              return {
                exe = "prettierd",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          go = {
            function()
              return {
                exe = "golines",
                args = {
                  "--max-len=100",
                  "--base-formatter=gofumpt",
                  utils.escape_path(utils.get_current_buffer_file_path()),
                },
                stdin = true,
              }
            end,
          },
          html = {
            function()
              return {
                exe = "prettierd",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          javascript = {
            function()
              return {
                exe = "prettierd",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          javascriptreact = {
            function()
              return {
                exe = "prettierd",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          json = {
            function()
              return {
                exe = "prettierd",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          lua = {
            function()
              return {
                exe = "stylua",
                args = {
                  "--indent-type",
                  "Spaces",
                  "--indent-width",
                  "2",
                  "--search-parent-directories",
                  "--stdin-filepath",
                  utils.escape_path(utils.get_current_buffer_file_path()),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end,
          },
          markdown = {
            function()
              return {
                exe = "cbfmt",
                args = {
                  "--stdin-filepath",
                  utils.escape_path(utils.get_current_buffer_file_path()),
                  "--best-effort",
                },
                stdin = true,
              }
            end,
          },
          sh = {
            function()
              return {
                exe = "shfmt",
                args = {
                  "--filename",
                  utils.escape_path(utils.get_current_buffer_file_path()),
                  "-",
                },
                stdin = true,
              }
            end,
          },
          typescript = {
            function()
              return {
                exe = "prettierd",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          typescriptreact = {
            function()
              return {
                exe = "prettierd",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
        },
      })

      local formatGroup = vim.api.nvim_create_augroup("format", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = formatGroup,
        pattern = "*",
        command = "FormatWrite",
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
    },
    config = function()
      require("go").setup({
        tag_transform = "camelcase",
        tag_options = "",

        icons = false,
        lsp_cfg = false,
        lsp_gofumpt = false,
        lsp_keymaps = false,
        lsp_codelens = false,
        lsp_document_formatting = false,
        lsp_inlay_hints = {
          enable = false,
        },
        dap_debug = false,
        dap_debug_keymap = false,
        luasnip = true,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "folke/trouble.nvim",
    opts = {
      focus = true,
      warn_no_results = false,
      open_no_results = true,
      keys = {
        q = "close",
        ["<esc>"] = "close",
        ["<cr>"] = "jump_close",
        ["<c-s>"] = "jump_split",
        ["<c-v>"] = "jump_vsplit",
        p = "toggle_preview",
        ["<space>"] = "fold_toggle",
        s = {
          action = function(view)
            local f = view:get_filter("severity")
            local severity = ((f and f.filter.severity or 0) + 1) % 5
            view:filter({ severity = severity }, {
              id = "severity",
              template = "{hl:Title}Filter:{hl} {severity}",
              del = severity == 0,
            })
          end,
          desc = "Toggle Severity Filter",
        },
      },
      modes = {
        diagnostics = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.5,
          },
        },
        symbols = {
          desc = "document symbols",
          mode = "lsp_document_symbols",
          focus = true,
          win = { position = "right" },
        },
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle<cr>",
        desc = "Symbols (Trouble)",
      },
    },
  },
}
