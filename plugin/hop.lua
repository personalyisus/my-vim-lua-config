vim.pack.add({
  { src = gh("phaazon/hop.nvim") },
})

require("hop").setup()
vim.api.nvim_set_keymap("n", "S", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "s", ":HopWord<cr>", { silent = true })
