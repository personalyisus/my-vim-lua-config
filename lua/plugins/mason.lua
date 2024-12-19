return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "flake8",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({})
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                  },
                },
                completion = {
                  callSnippet = "Replace",
                },
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
        ["eslint"] = function()
          local lspconfig = require("lspconfig")

          lspconfig.eslint.setup({
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
            end,
          })
        end,
        -- commenting out tsserver since it is not available for mason for some reason?
        -- ["tsserver"] = function()
        --   local lspconfig = require("lspconfig")
        --   lspconfig.tsserver.setup({
        --     on_attach = function(client)
        --       client.server_capabilities.documentFormattingProvider = true
        --     end,
        --   })
        -- end,
        -- instead trying out vtsls
      },
    },
  },
  "neovim/nvim-lspconfig",
}
