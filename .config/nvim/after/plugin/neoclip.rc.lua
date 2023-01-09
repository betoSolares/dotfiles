local status, neoclip = pcall(require, "neoclip")

if not status then
  return
end

neoclip.setup({
  history = 1000,
  enable_persistent_history = false,
  length_limit = 1048576,
  continuous_sync = false,
  db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
  filter = nil,
  default_register = '"',
  default_register_macros = "q",
  enable_macro_history = true,
  content_spec_column = false,
  on_select = {
    move_to_front = true,
  },
  on_paste = {
    set_reg = true,
    move_to_front = true,
  },
  on_replay = {
    set_reg = false,
    move_to_front = false,
  },
  keys = {
    telescope = {
      i = {
        select = "<CR>",
        paste = "<C-p>",
        paste_behind = "<C-P>",
        replay = "<C-q>", -- replay a macro
        delete = "<C-d>", -- delete an entry
        custom = {},
      },
      n = {
        select = "<CR>",
        paste = "p",
        paste_behind = "P",
        replay = "q",
        delete = "d",
        custom = {},
      },
    },
  },
})

vim.keymap.set("n", '""', ":Telescope neoclip<CR>", { noremap = true, silent = true })
