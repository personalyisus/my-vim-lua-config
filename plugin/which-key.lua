vim.pack.add({
  { src = gh("folke/which-key.nvim") },
})

vim.o.timeout = true
vim.o.timeoutlen = 300

require("which-key").setup({
  -- Yisus note: I don't want to see which-key for operators, motions, text_objects, windows, nav, z, g
  plugins = {
    presets = {
      operators = false,     -- adds help for operators like d, y, ...
      motions = false,       -- adds help for motions
      text_objects = false,  -- help for text objects triggered after entering an operator
      windows = false,       -- default bindings on <c-w>
      nav = false,           -- misc bindings to work with windows
      z = false,             -- bindings for folds, spelling and others prefixed with z
      g = false,             -- bindings for prefixed with g
    },
  },
})
