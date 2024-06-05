-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here


local opt = vim.opt

vim.g.mapleader = " "
vim.g.wrap = "nowrap"

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

-- Fix for <Tab> map has been disabled or is claimed by another plugin on copilot?
-- based on this https://www.reddit.com/r/neovim/comments/sk70rk/comment/i1vro1l/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.g.copilot_assume_mapped = true

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end
