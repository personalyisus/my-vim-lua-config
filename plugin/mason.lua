vim.pack.add({
  { src = gh("mason-org/mason.nvim") },
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason-lspconfig.nvim") },
})

require("mason").setup({ ensure_installed = { "stylua", "shfmt" } })

require("mason-lspconfig").setup({
  ensure_installed = {
    -- add servers here, mason-lspconfig will install them
  },
})

-- auto-enable every server mason has already installed
vim.lsp.enable(require("mason-lspconfig").get_installed_servers())