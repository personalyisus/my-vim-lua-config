return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      -- Conform will run multiple formatters sequentially
      -- Use a sub-list to run only the first available formatter
      ["javascript"] = { "prettier" },
      ["javascriptreact"] = { "prettier" },
      ["javascript.jsx"] = { "prettier" },
      ["typescript"] = { "prettier" },
      ["typescriptreact"] = { "prettier" },
      ["astro"] = { "prettier" },
      ["scss"] = { "prettier" },
      -- ["*"] = { "prettier" },
    },
  },
}
