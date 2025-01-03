local opt = vim.opt

-- Map space to leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.cursorline = true

vim.o.splitright = true
vim.o.splitbelow = true


opt.smartindent = true
opt.number = true
opt.relativenumber = false -- for white spaces
opt.signcolumn = "yes"
opt.autoread = true
opt.wildmenu = true

-- Integration with the system clipboard
opt.clipboard = { "unnamed", "unnamedplus" }

-- Navigation
opt.scrolloff = 3     -- Lines to scroll when cursor leaves screen
opt.sidescrolloff = 3 -- Lines to scroll horizontally

-- Backups
opt.backup = true
opt.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.writebackup = true

-- Undo & History
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.undodir = vim.fn.expand("~") .. "/.local/share/nvim/undo"
opt.shada = { "!", "'1000", "<50", "s10", "h" } -- Increase the shadafile size so that history is longer


opt.hlsearch = false
opt.incsearch = true
opt.autoindent = true
opt.smarttab = true
opt.hidden = true


-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

opt.path = "**"

-- Ignore some folders and files with find
opt.wildignore = {
  "**/node_modules/**", "**/coverage/**", "**/.idea/**", "**/.git/**",
  "**/.nuxt/**"
}

opt.wrap = false

vim.api.nvim_set_option_value("updatetime", 100, {})
vim.api.nvim_set_option_value("synmaxcol", 200, {})
vim.opt.updatetime = 100

opt.ignorecase = true
opt.showmatch = true
opt.cursorline = true
opt.termguicolors = true

vim.opt.guicursor = ""


vim.cmd([[
  hi! SignColumn guibg=NONE
  set shortmess+=W
  set noswapfile
]])

vim.cmd [[
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
  augroup END

]]

vim.o.background = require("utils").read()
