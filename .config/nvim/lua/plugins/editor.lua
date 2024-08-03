return {
  {
    "cxwx/specs.nvim",
    keys = {
      {
        "<leader>w",
        function()
          require("specs").show_specs({ width = 100, winhl = "Cursor", delay_ms = 0, inc_ms = 15 })
        end,
        desc = "Specs",
      },
    },
    config = function()
      require("specs").setup({
        show_jumps = true,
        min_jump = 5,
        popup = {
          delay_ms = 0,
          inc_ms = 15,
          blend = 10,
          width = 10,
          winhl = "Cursor",
          fader = require("specs").linear_fader,
          resizer = require("specs").slide_resizer,
        },
        ignore_filetypes = {},
        ignore_buftypes = {
          nofile = true,
        },
      })
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    opts = {},
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      local function provider(_, _, _)
        return { "treesitter", "indent" }
      end

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)

          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)

            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end

            break
          end

          curWidth = curWidth + chunkWidth
        end

        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      require("ufo").setup({
        open_fold_hl_timeout = 150,
        provider_selector = provider,
        enable_get_fold_virt_text = true,
        fold_virt_text_handler = handler,
        close_fold_kinds = {},
        preview = {},
      })
    end,
    event = "UIEnter",
    keys = {
      { "<space>", "za", desc = "Open/close fold" },
      { "<leader><space>", "zA", desc = "Open/close all folds" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          dynamic_preview_title = true,
          mappings = {
            i = {
              ["<C-s>"] = actions.select_horizontal,
              ["<Tab>"] = actions.move_selection_next,
              ["<S-Tab>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
              ["q"] = actions.close,
              ["<C-s>"] = actions.select_horizontal,
            },
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
          },
        },
      })

      require("telescope").load_extension("file_browser")
    end,
    keys = {
      {
        "<leader>f",
        function()
          require("telescope.builtin").find_files({
            no_ignore = false,
            hidden = true,
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", "**/.git/", "--exclude", "**/vendor/" },
          })
        end,
        desc = "Search files",
      },
      {
        "<leader>t",
        function()
          require("telescope.builtin").tags()
        end,
        desc = "Search tags",
      },
      {
        "<leader>e",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Search diagnostics",
      },
      {
        "<leader><Tab>",
        function()
          require("telescope").extensions.file_browser.file_browser({
            respect_gitignore = true,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40, width = 80 },
          })
        end,
        desc = "Open file browser",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
        untracked = { text = "+" },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
        untracked = { text = "+" },
      },
      signcolumn = true,
      numhl = true,
      linehl = false,
      word_diff = false,
      current_line_blame = false,
      attach_to_untracked = true,
    },
    event = "UIEnter",
    keys = {
      { "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle git blame" },
      {
        "<leader>gc",
        function()
          require("gitsigns").toggle_numhl()
          require("gitsigns").toggle_signs()
        end,
        desc = "Toogle git signs",
      },
    },
  },
}
