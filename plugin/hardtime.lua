vim.pack.add({
  { src = gh("m4xshen/hardtime.nvim") },
  { src = gh("MunifTanjim/nui.nvim") },
})

require("hardtime").setup({ allow_different_key = true, disabled_keys = {} })
