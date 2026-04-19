vim.pack.add({
  { src = gh("m4xshen/hardtime.nvim") },
  { src = gh("MunifTanjim/nui.nvim") },
  { src = gh("nvim-lua/plenary.nvim") },
})

require("hardtime").setup({ allow_different_key = true, disabled_keys = {} })
