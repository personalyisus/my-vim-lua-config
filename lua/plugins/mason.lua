return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { "stylua", "shfmt" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufRead" },
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead" },
  },
}
