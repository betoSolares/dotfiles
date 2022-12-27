local status, telescope = pcall(require, 'telescope')

if (not status) then return end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-c>'] = actions.select_horizontal,
        ['<Tab>'] = actions.move_selection_next,
        ['<S-Tab>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous
      },
      n = {
        ['q'] = actions.close,
        ['<C-c>'] = actions.select_horizontal,
      },
    }
  }
}

vim.keymap.set('n', '<leader>s', function()
  builtin.find_files({
    no_ignore = false,
    hidden = true,
    find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '**/.git/' }
  })
end)

vim.keymap.set('n', '<leader>e', function()
  builtin.diagnostics()
end)
