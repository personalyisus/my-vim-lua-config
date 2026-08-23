vim.pack.add({
  { src = gh("mason-org/mason.nvim") },
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason-lspconfig.nvim") },
})

require("mason").setup({ ensure_installed = { "stylua", "shfmt" } })

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  },
})

-- Tell lua_ls that `vim` is a global and where Neovim's runtime files are
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
        checkThirdParty = false,
      },
    },
  },
})

-- Feed blink.cmp's LSP capabilities into every server
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- auto-enable every server mason has already installed
vim.lsp.enable(require("mason-lspconfig").get_installed_servers())