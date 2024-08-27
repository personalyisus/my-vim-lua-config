return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua", "lua_ls" },
      rust = { "rustfmt" },
      -- Conform will run multiple formatters sequentially
      -- Use a sub-list to run only the first available formatter
      ["javascript"] = { "prettier", "eslint_d" },
      ["javascriptreact"] = { "prettier", "eslint_d" },
      ["javascript.jsx"] = { "prettier", "eslint_d" },
      ["typescript"] = { "prettier", "eslint_d" },
      ["typescriptreact"] = { "prettier", "eslint_d" },
      ["svelte"] = { "prettier" },
      ["jsonc"] = { "fixjson", "jsonls" },
      ["json"] = { "fixjson", "jsonls" },
      ["astro"] = { "prettier" },
      ["scss"] = { "prettier" },
      ["html"] = { "prettier" },
      -- ["*"] = { "prettier" },
    },
  },
}
