return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Taken from https://www.reddit.com/r/neovim/comments/1hhiidm/a_few_nice_fzflua_configurations_now_that_lazyvim/

    oldfiles = {
      include_current_session = true,
    },
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100, -- 100KB
      },
    },
  },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})
    -- vim.keymap.set("n", "<c-P>", require('fzf-lua').files, { desc = "Fzf Files" })
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
