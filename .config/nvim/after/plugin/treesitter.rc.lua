local status, ts = pcall(require, "nvim-treesitter.configs")

if not status then
  return
end

ts.setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {},
  },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
  ensure_installed = {
    "tsx",
    "javascript",
    "go",
    "gomod",
    "python",
    "lua",
    "dockerfile",
    "bash",
    "make",
    "toml",
    "json",
    "yaml",
    "css",
    "html",
    "markdown",
  },
})
