local status, packer = pcall(require, 'packer')

if (not status) then
  print('Packer not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- plugin manager
  use 'nvim-lua/plenary.nvim' -- common utilities
  use 'nvim-tree/nvim-web-devicons' -- file icons
  use 'navarasu/onedark.nvim' -- colorscheme
  use 'nvim-lualine/lualine.nvim' -- statusline
  use 'windwp/nvim-autopairs' -- autopair quotes, brackets, etc
  use 'nvim-telescope/telescope.nvim' -- fuzzy finder
  use 'lewis6991/gitsigns.nvim' -- git status signs
  use 'ludovicchabant/vim-gutentags' -- ctags integration
  use 'neovim/nvim-lspconfig' -- lsp client
  use 'onsails/lspkind.nvim' -- lsp pictograms
  use 'j-hui/fidget.nvim' -- lsp progress ui
  use 'hrsh7th/cmp-nvim-lsp' -- lsp completion from lsp client
  use 'hrsh7th/cmp-buffer' -- lsp completion from buffer
  use 'hrsh7th/nvim-cmp' -- lsp completion core functions
  use 'L3MON4D3/LuaSnip' -- snippets
  use 'glepnir/lspsaga.nvim' -- lsp ui
  use 'jose-elias-alvarez/null-ls.nvim' -- lsp code actions
  use { -- better parsing with tree sitter
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'ray-x/go.nvim'
end)
