return {
  "Exafunction/windsurf.nvim",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      virtual_text = {
        -- Enabling virtual text completions,
        -- later I can disable cmp if I want to
        -- but I'm fairly certain that I will want to disable it
        enabled = true,
      },
    })
  end,
}
