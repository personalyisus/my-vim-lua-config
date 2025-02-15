return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { "stylua", "shfmt" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "stevearc/conform.nvim" },
    event = { "BufRead" },
    opts = {
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        vtsls = function()
          require("lspconfig").vtsls.setup({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "astro" },
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = true
            end,
          })
        end,
        lua_ls = function()
          require("lspconfig").lua_ls.setup({
            filetypes = { "lua" },
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
                completion = { callSnippet = "Replace" },
                diagnostics = { globals = { "vim" } },
              },
            },
          })
        end,
        eslint = function()
          require("lspconfig").eslint.setup({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "astro" },
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
            end,
          })
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },
}
