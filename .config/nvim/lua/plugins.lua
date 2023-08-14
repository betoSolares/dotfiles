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
  use("ray-x/guihua.lua") -- floating window support
  use({ "catppuccin/nvim", as = "catppuccin" }) -- colorscheme
  use("nvim-tree/nvim-web-devicons") -- file icons
  use("nvim-lualine/lualine.nvim") -- statusline
  use("edluffy/specs.nvim") -- cursor highlighting
  use({ "j-hui/fidget.nvim", tag = "legacy" }) -- lsp progress ui
  use("onsails/lspkind.nvim") -- lsp symbols
  use("uga-rosa/ccc.nvim") -- color picker
  use("luukvbaal/statuscol.nvim") -- configurable statuscolumn
  use("kevinhwang91/nvim-ufo") -- better folding
  use("nvim-telescope/telescope.nvim") -- fuzzy finder
  use("nvim-telescope/telescope-file-browser.nvim") -- file explorer
  use("AckslD/nvim-neoclip.lua") -- clipboard manager
  use("windwp/nvim-autopairs") -- autopair quotes, brackets, etc
  use("ludovicchabant/vim-gutentags") -- ctags integration
  use("lewis6991/gitsigns.nvim") -- git status signs
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- snippet completion
  use("lukas-reineke/cmp-under-comparator") -- completion sorting
  use("hrsh7th/cmp-buffer") -- completion from buffer
  use("hrsh7th/cmp-nvim-lsp") -- completion from lsp client
  use("hrsh7th/nvim-cmp") -- completion engine
  use({ -- tree sitter configuration
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })
  use("m-demare/hlargs.nvim") -- highlight args definitions
  use("nvim-treesitter/nvim-treesitter-textobjects") -- tree sitter textobjects
  use("windwp/nvim-ts-autotag") -- tree sitter auto tag
  use("mfussenegger/nvim-lint") -- linter
  use("mhartington/formatter.nvim") -- formatter
  use("glepnir/lspsaga.nvim") -- lsp ui helpers
  use("neovim/nvim-lspconfig") -- lsp client
  use("ray-x/go.nvim") -- go tools
end)
