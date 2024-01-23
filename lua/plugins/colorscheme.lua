return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000000,
    opts = {
      style = "moon",
    },
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function() 
  --     vim.cmd([[colorscheme catppuccin-macchiato]])
  --
  -- end },
}
