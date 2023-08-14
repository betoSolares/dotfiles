-- don't comment on new lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

-- reload on external changes
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "BufEnter", "FocusGained" }, {
  pattern = "*",
  command = ":checktime",
})

-- turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- highlight yanked text
local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 100,
    })
  end,
})
