local status, ts = pcall(require, 'nvim-treesitter.configs')

if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    'tsx',
    'javascript',
    'go',
    'gomod',
    'python',
    'lua',
    'dockerfile',
    'bash',
    'make',
    'toml',
    'json',
    'yaml',
    'css',
    'html'
  }
}
