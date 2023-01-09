local status, specs = pcall(require, "specs")

if not status then
  return
end

specs.setup({
  show_jumps = true,
  min_jump = 5,
  popup = {
    delay_ms = 0,
    inc_ms = 15,
    blend = 10,
    width = 10,
    winhl = "Cursor",
    fader = specs.linear_fader,
    resizer = specs.slide_resizer,
  },
  ignore_filetypes = {},
  ignore_buftypes = {
    nofile = true,
  },
})

vim.keymap.set(
  "n",
  "<leader>w",
  ':lua require("specs").show_specs({width = 100, winhl = "Cursor", delay_ms = 0, inc_ms = 15})<CR>',
  { noremap = true, silent = true }
)
