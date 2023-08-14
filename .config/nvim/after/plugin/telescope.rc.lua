local status, telescope = pcall(require, "telescope")

if not status then
  return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    dynamic_preview_title = true,
    mappings = {
      i = {
        ["<C-c>"] = actions.select_horizontal,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["q"] = actions.close,
        ["<C-c>"] = actions.select_horizontal,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
    },
  },
})

telescope.load_extension("neoclip")
telescope.load_extension("file_browser")

vim.keymap.set("n", "<leader>f", function()
  builtin.find_files({
    no_ignore = false,
    hidden = true,
    find_command = { "fd", "--type", "f", "--hidden", "--exclude", "**/.git/" },
  })
end)

vim.keymap.set("n", "<leader>t", function()
  builtin.tags()
end)

vim.keymap.set("n", "<leader>e", function()
  builtin.diagnostics()
end)

vim.keymap.set("n", "<leader><Tab>", function()
  telescope.extensions.file_browser.file_browser({
    respect_gitignore = true,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40, width = 80 },
  })
end)
