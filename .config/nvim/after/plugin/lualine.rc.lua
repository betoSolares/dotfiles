local status, lualine = pcall(require, "lualine")

if not status then
  return
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "onedark",
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
})
