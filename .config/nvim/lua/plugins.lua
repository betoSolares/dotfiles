local status, packer = pcall(require, "packer")

if not status then
  print("Packer not installed")
  return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
  use("wbthomason/packer.nvim") -- plugin manager
  use("nvim-lua/plenary.nvim") -- common utilities
  use("kevinhwang91/promise-async") -- async functions
  use("nvim-tree/nvim-web-devicons") -- file icons
  use("navarasu/onedark.nvim") -- colorscheme
  use("nvim-lualine/lualine.nvim") -- statusline
  use("edluffy/specs.nvim") -- cursor highlighting
  use("windwp/nvim-autopairs") -- autopair quotes, brackets, etc
  use("kevinhwang91/nvim-ufo") -- better folding
  use("nvim-telescope/telescope.nvim") -- fuzzy finder
  use("lewis6991/gitsigns.nvim") -- git status signs
  use("ludovicchabant/vim-gutentags") -- ctags integration
  use("neovim/nvim-lspconfig") -- lsp client
  use("onsails/lspkind.nvim") -- lsp pictograms
  use("j-hui/fidget.nvim") -- lsp progress ui
  use("hrsh7th/cmp-nvim-lsp") -- completion from lsp client
  use("hrsh7th/cmp-buffer") -- completion from buffer
  use("hrsh7th/nvim-cmp") -- completion core functions
  use("lukas-reineke/cmp-under-comparator") -- completion sorting
  use("L3MON4D3/LuaSnip") -- snippets
  use("glepnir/lspsaga.nvim") -- lsp ui
  use("jose-elias-alvarez/null-ls.nvim") -- lsp code actions
  use({ -- better parsing with tree sitter
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })
  use("nvim-treesitter/nvim-treesitter-textobjects") -- tree sitter textobjects
  use("windwp/nvim-ts-autotag") -- autoclose html tags
  use("m-demare/hlargs.nvim") -- highlight args definitions and usages
  use("AckslD/nvim-neoclip.lua") -- clipboard manager
  use("nvim-tree/nvim-tree.lua") -- tree file explorer
  use("ray-x/go.nvim") -- go support
  use("ray-x/guihua.lua") -- go.nvim floating window support
end)
