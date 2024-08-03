return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    opts = {
      default = true,
      color_icons = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "b:gitsigns_status",
          "gutentags#statusline",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 0,
            symbols = {
              modified = "[~]",
              readonly = "RO",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_x = { "fileformat", "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { require("statuscol.builtin").foldfunc }, click = "v:lua.ScFa" },
          { text = { " %s" }, click = "v:lua.ScSa" },
          { text = { require("statuscol.builtin").lnumfunc, " " }, click = "v:lua.ScLa" },
        },
      })
    end,
  },
}
