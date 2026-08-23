-- Neovim configuration options
-- See: https://www.lazyvim.org/configuration/general#options

local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.wrap = false

-- Values based on https://www.lazyvim.org/configuration/general#options
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.list = true -- Show some invisible characters (tabs...
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.shiftwidth = 2 -- Size of an indent
opt.swapfile = false -- disable swap file
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.undofile = true
opt.undolevels = 10000

-- Neovim 0.10+ has smooth scrolling built in
if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end
