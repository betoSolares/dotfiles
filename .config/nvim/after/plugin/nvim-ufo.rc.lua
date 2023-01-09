local status, ufo = pcall(require, "ufo")

if not status then
  return
end

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local function provider(_, _, _)
  return { "treesitter", "indent" }
end

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0

  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)

    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)

      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end

      break
    end

    curWidth = curWidth + chunkWidth
  end

  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

ufo.setup({
  open_fold_hl_timeout = 150,
  provider_selector = provider,
  fold_virt_text_handler = handler,
})

vim.keymap.set("n", "<space>", "za", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><space>", "&foldlevel ? 'zM' :'zR'", { noremap = true, silent = true, expr = true })
