-- bootstrap lazy.nvim, LazyVim and your plugins
-- require("config.lazy")

require('config.options')
require('config.keymaps')
require('config.autocmds')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Propbable move these out to a keymaps file

require("lazy").setup("plugins")


