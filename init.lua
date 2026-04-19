-- Yisusnote: adding this to allow resolving with vim.pack.add()
-- similarly to how its done on lazy or other package managers,
-- as per nvim docs https://neovim.io/doc/user/pack/ (Create custom Lua helpers)
gh = function(x)
  return "https://github.com/" .. x
end

-- profiling if PROF environment variable is set
-- based on https://github.com/folke/snacks.nvim/blob/main/docs/profiler.md#profiling-neovim-startup
if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      -- event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      event = "VeryLazy",
    },
  })
end

-- bootstrap lazy.nvim, LazyVim and your plugins
-- require("config.lazy")

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- YISUSTODO: Putting here some plugin stuff through vim.pack on the meantime,
-- but this should be automated to take stuff hopefully in a similar way to the lazyspec
-- https://lazy.folke.io/spec

-- vim.pack.add({
--   { src = gh("catppuccin/nvim") },
--   { src = gh("sphamba/smear-cursor.nvim") },
-- })

-- Yisustodo: this can probably be automated by leverating the event
-- PackChanged https://neovim.io/doc/user/pack/#vim.pack-events
-- vim.cmd([[colorscheme catppuccin-macchiato]])

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
-- require("lazy").setup({
--   defaults = {
--     lazy = true,
--   },
--   spec = {
--     -- import your plugins
--     { import = "plugins" },
--   },
--   -- Configure any other settings here. See the documentation for more details.
--   -- colorscheme that will be used when installing plugins.
--   -- install = { colorscheme = { "tokyonight" } },
--   -- automatically check for plugin updates
--   checker = { enabled = false },
--   performance = {
--     rtp = {
--       -- disable some rtp plugins
--       disabled_plugins = {
--         "gzip",
--         -- "matchit",
--         -- "matchparen",
--         -- "netrwPlugin",
--         "tarPlugin",
--         "tohtml",
--         "tutor",
--         "zipPlugin",
--       },
--     },
--   },
-- })
