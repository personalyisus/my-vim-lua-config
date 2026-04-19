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

-- {
--  {
--     "mason-org/mason.nvim",
--     cmd = "Mason",
--     keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
--     build = ":MasonUpdate",
--     opts = {
--       ensure_installed = { "stylua", "shfmt" },
--     },
--   },
--   {
--     -- Only needed for its lsp/ directory — never call require('lspconfig').setup()
--     "neovim/nvim-lspconfig",
--     lazy = true,
--   },
--   {
--     "mason-org/mason-lspconfig.nvim",
--     lazy = false,
-- opts = {
--   ensure_installed = {
--     "lua_ls",
--     -- add servers here, mason-lspconfig will install them
--   },
--     },
--     config = function(_, opts)
--       require("mason-lspconfig").setup(opts)
--       -- auto-enable every server mason has already installed
--       vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
--     end,
--   },
-- }
