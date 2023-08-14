local status, formatter = pcall(require, "formatter")

if not status then
  return
end

local utils = require("formatter.util")
local css_format = require("formatter.filetypes.css")
local html_format = require("formatter.filetypes.html")
local js_format = require("formatter.filetypes.javascript")
local json_format = require("formatter.filetypes.json")
local ts_format = require("formatter.filetypes.typescript")

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
      css_format.prettierd(),
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
      html_format.prettierd(),
    },
    javascript = {
      js_format.prettierd(),
    },
    javascriptreact = {
      js_format.prettierd(),
    },
    json = {
      json_format.prettierd(),
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
      ts_format.prettierd(),
    },
    typescriptreact = {
      ts_format.prettierd(),
    },
  },
})

local format_group = vim.api.nvim_create_augroup("FormatAutogroup", {})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = format_group,
  pattern = "*",
  command = "FormatWrite",
})
