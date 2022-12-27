-- don't comment on new lines
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  command = 'setlocal formatoptions-=cro'
})

-- reload on external changes
vim.api.nvim_create_autocmd(
  { 'CursorHold', 'CursorHoldI', 'BufEnter', 'FocusGained' },
  {
    pattern = '*',
    command = ':checktime'
  }
)
