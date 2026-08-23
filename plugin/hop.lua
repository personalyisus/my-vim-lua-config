vim.pack.add({
  { src = gh("phaazon/hop.nvim") },
})

require("hop").setup()
vim.keymap.set("n", "S", ":HopChar2<cr>", { silent = true })
vim.keymap.set("n", "s", ":HopWord<cr>", { silent = true })
