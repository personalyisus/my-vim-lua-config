-- NOTE: After install, run :TSUpdate to install parsers
vim.pack.add({
  { src = gh("nvim-treesitter/nvim-treesitter") },
})

vim.schedule(function()
require("nvim-treesitter.configs").setup({
  ensure_installed = { "typescript", "css", "javascript", "svelte" },

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,

    disable = function(_, buf)
      local max_filesize = 200 * 1024 -- 200 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    additional_vim_regex_highlighting = false,
  },
})
end)
