local status, _ = pcall(require, "vim-gutentags")

if not status then
  return
end

vim.g.gutentags_file_list_command = "fd --type f --hidden --exclude **/.git/"
