return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- keys = {
  --   { "<leader>ff", "<cmd>lua require('fzf-lua').files<cr>", desc = "Find files in project" },
  --   { "<leader>fg", "<cmd>lua require('fzf-lua').live_grep<cr>", desc = "Live grep in project" },
  --   { "<leader>fb", "<cmd>lua require('fzf-lua').buffers<cr>", desc = "Buffers" },
  --   { "<leader>fh", "<cmd>lua require('fzf-lua').help_tags<cr>", desc = "Help tags" },
  --   { "<leader>fr", "<cmd>lua require('fzf-lua').lsp_references<cr>", desc = "Find references of the symbol under the cursor" },
  --   { "<leader>fd", "<cmd>lua require('fzf-lua').lsp_definitions<cr>", desc = "Find definitions of the symbol under the cursor" },
  --   { "<leader>ft", "<cmd>lua require('fzf-lua').lsp_type_definitions<cr>", desc = "Find type definitions of the symbol under the cursor" },
  -- },
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
