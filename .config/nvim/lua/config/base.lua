vim.cmd("autocmd!")

-- environment
local HOME = os.getenv("HOME")
vim.opt.directory = HOME .. "/.cache/nvim"
vim.opt.backupdir = HOME .. "/.cache/nvim"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- file format
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"

-- window
vim.opt.title = true
vim.opt.autoread = true
vim.opt.updatetime = 1000

-- buffers
vim.opt.hidden = true

-- backspace behaviour
vim.opt.backspace = "indent,eol,start"

-- completion
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.wildmenu = true

-- lines
vim.opt.wrap = false
vim.wo.cursorline = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.showmatch = true

-- lazy redraw
vim.opt.lazyredraw = true

-- indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 8

-- colorscheme
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- statusline
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.showmode = true

-- scrolling
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5

-- tabs
vim.opt.list = true
vim.opt.listchars = "nbsp:¬,tab:»·,trail:·,precedes:<,extends:>"
vim.opt.smarttab = true

-- split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- search
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- signcolumn
vim.opt.signcolumn = "yes"

-- foldcolumn
vim.o.fillchars = "eob: ,vert:│,fold: ,foldopen:,foldsep: ,foldclose:"

-- clipboard
vim.opt.clipboard:append({ "unnamedplus" })
