local status, lint = pcall(require, "lint")

if not status then
  return
end

local luacheck = lint.linters.luacheck
luacheck.args = {
  "--formatter",
  "plain",
  "--globals",
  "vim",
  "--codes",
  "--ranges",
  "-",
}

lint.linters_by_ft = {
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

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
