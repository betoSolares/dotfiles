local status, gitsigns = pcall(require, "gitsigns")

if not status then
  return
end

local on_attach = function(bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", opts)
  buf_set_keymap("n", "<leader>gc", ":Gitsigns toggle_numhl<CR>", opts)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if not vim.api.nvim_win_get_option(0, "diff") then
      gitsigns.setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "+",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "~",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = "-",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = "-",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = "~",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          untracked = {
            hl = "GitSignsAdd",
            text = "+",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
        },
        signcolumn = true,
        numhl = true,
        linehl = false,
        word_diff = false,
        current_line_blame = false,
        attach_to_untracked = true,
        on_attach = on_attach,
      })
    end
  end,
})
