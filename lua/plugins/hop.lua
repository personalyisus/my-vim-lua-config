return {
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    event = { "BufRead" },
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "S", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "s", ":HopWord<cr>", { silent = true })
    end,
  },
}
