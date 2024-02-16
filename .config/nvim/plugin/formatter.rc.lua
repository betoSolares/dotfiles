local status, formatter = pcall(require, "formatter")

if not status then
  return
end

local utils = require("formatter.util")

formatter.setup({
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

local format_group = vim.api.nvim_create_augroup("FormatAutogroup", {})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = format_group,
  pattern = "*",
  command = "FormatWrite",
})
