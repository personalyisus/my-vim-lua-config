return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    -- Ensure all installed parsers are enabled.
    ensure_installed = { "typescript", "css", "javascript", "svelte" },

    -- Automatically install missing parsers when entering buffer.
    auto_install = true,

    highlight = {
      -- Enable highlighting
      enable = true,

      -- List of language that will be disabled
      disable = {},

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your Neovim startup time.
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
