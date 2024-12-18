return {
  "neovim/nvim-lspconfig",
  event = "BufEnter",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  ---@class PluginLspOpts
  opts = {
    -- options for vim.diagnostic.config()
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●", -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
    },
    -- add any global capabilities here
    capabilities = {},
    -- Automatically format on save
    autoformat = false,
    -- options for vim.lsp.buf.format
    -- `bufnr` and `filter` is handled by the LazyVim formatter,
    -- but can be also overridden when specified
    format = {
      formatting_options = nil,
      timeout_ms = 1000,
    },
    -- LSP Server Settings
    ---@type lspconfig.options
    servers = {
      eslint = {
        mason = false,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      },
      tsserver = {
        mason = false,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = true
        end,
      },
      lua_ls = {
        mason = false,
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        -- Use this to add any additional keymaps
        -- for specific lsp servers
        ---@type LazyKeysSpec[]
        -- keys = {},

        -- Taken from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
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
      },
    },
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(serverName:string, serverOptions:_.lspconfig.options):boolean?>
    setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(serverName, serverOptions)
      --   require("lspconfig")[serverName].setup(serverOptions)
      --   return true
      -- end,
    },
  },
  ---@param opts PluginLspOpts
  config = function(_, opts)
    -- setup autoformat
    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local servers = opts.servers
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      opts.capabilities or {}
    )

    local function defaultSetupFunction(serverName)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[serverName] or {})

      -- Because there's nothing on opts.setup,
      -- this is not actually doing anything???
      if opts.setup[serverName] then
        if opts.setup[serverName](serverName, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](serverName, server_opts) then
          return
        end
      end

      require("lspconfig")[serverName].setup(server_opts)
    end

    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    -- get all the servers that are available through mason-lspconfig
    -- local all_mslp_servers = {}
    -- if have_mason then
    --   all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    -- end

    local ensure_installed = {} ---@type string[]
    for serverName, server_opts in pairs(servers) do
      if server_opts then
        if server_opts.mason then
          ensure_installed[#ensure_installed + 1] = serverName
        end
      end
    end

    if have_mason then
      mlsp.setup({
        ensure_installed,
        handlers = {
          function(serverName)
            defaultSetupFunction(serverName)
          end,
        },
      })
    end
  end,
}
