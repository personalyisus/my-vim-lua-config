return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,
  cmd = "FzfLua",
  keys = { "<c-p>", "<leader>ff", "<leader>fg", "<leader>fb", "<leader>fh", "<leader>fr" },
  config = function()
    -- calling `setup` is optional for customization
    --
    -- simplifying my life by using the telescope profile
    -- taken from here https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/profiles/README.md
    require("fzf-lua").setup({
      "telescope",
      -- yisusnote: configuring this to use my custom ripgrep config file
      grep = {
        RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
      },
    })
    vim.keymap.set("n", "<c-P>", require("fzf-lua").files, { desc = "Fzf Files" })
    vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "Find files in project" })
    vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "Live grep in project" })
    vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags, { desc = "Help tags" })
    vim.keymap.set(
      "n",
      "<leader>fr",
      require("fzf-lua").lsp_references,
      { desc = "Find references of the symbol under the cursor" }
    )
    vim.keymap.set(
      "n",
      "<leader>fd",
      require("fzf-lua").lsp_definitions,
      { desc = "Find definitions of the symbol under the cursor" }
    )
    vim.keymap.set(
      "n",
      "<leader>ft",
      require("fzf-lua").lsp_typedefs,
      { desc = "Find type definitions of the symbol under the cursor" }
    )
  end,
}
