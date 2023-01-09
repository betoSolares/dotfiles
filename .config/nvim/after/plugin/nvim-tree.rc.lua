local status, nt = pcall(require, "nvim-tree")

if not status then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nt.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "n", action = "create" },
        { key = "<C-c>", action = "split" },
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

vim.keymap.set("n", "<leader><Tab>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
