return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "Exafunction/codeium.nvim",
    },
  },
  event = "InsertEnter",
  -- optional: provides snippets for the snippet source
  -- dependencies = "rafamadriz/friendly-snippets",

  -- use a release tag to download pre-built binaries
  version = "*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = "super-tab",
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "accept", "fallback" },
    },
    -- snippets = {
    --   preset = "default",
    -- },
    fuzzy = {
      prebuilt_binaries = {
        download = true,
      },
    },
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },
    -- Yisusnote: Using manual completion list selection
    -- as noted in https://cmp.saghen.dev/configuration/completion.html#list
    -- since it got annoying trying to find something via / and then
    -- the list automatically opens and auto selects and item
    completion = {
      list = {
        selection = { preselect = false, auto_insert = false },
      },
    },
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "codeium", -- Codeium sources and provider as per https://github.com/Exafunction/windsurf.nvim?tab=readme-ov-file#blinkcmp
      },
      providers = {
        codeium = { name = "Codeium", module = "codeium.blink", async = true },
      },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = false,
      },
    },
  },
  opts_extend = { "sources.default" },
}
