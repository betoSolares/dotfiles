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

-- lsp key bindings
local lspGroup = vim.api.nvim_create_augroup("LspGroup", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = lspGroup,
  pattern = "*",
  callback = function(e)
    local opts = { buffer = e.buf }

    vim.keymap.set("n", "<leader>gd", function()
      vim.lsp.buf.definition()
    end, opts)

    vim.keymap.set("i", "<C-k>", function()
      vim.lsp.buf.signature_help()
    end, opts)

    vim.keymap.set("n", "<leader>i", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
    end, {})
  end,
})
