return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        color_overrides = {
          mocha = {
            base = "#171717",
            mantle = "#171717",
            crust = "#121212",
          },
        },
        integrations = {
          cmp = true,
          fidget = true,
          gitsigns = true,
          lsp_saga = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          nvimtree = true,
          treesitter = true,
          telescope = {
            enabled = true,
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
