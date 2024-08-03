return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "astro",
          "bash",
          "comment",
          "css",
          "dockerfile",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "html",
          "javascript",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "tsx",
          "typescript",
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        modules = {},
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
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
  {
    "m-demare/hlargs.nvim",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
