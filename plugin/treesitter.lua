-- NOTE: After install, run :TSUpdate to install parsers.
-- The new nvim-treesitter rewrite (Neovim 0.12+) has no configs module —
-- highlighting is handled by Neovim's built-in treesitter via FileType autocmds.
vim.pack.add({
  { src = gh("nvim-treesitter/nvim-treesitter") },
})

-- opt packages need an explicit packadd to land on the rtp
vim.cmd("packadd nvim-treesitter")

-- Install essential parsers (async, no-op if already installed)
require("nvim-treesitter").install({ "typescript", "css", "javascript", "svelte" })

-- Enable treesitter highlighting for every filetype Neovim supports,
-- skipping large files
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local max_filesize = 200 * 1024 -- 200 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    pcall(vim.treesitter.start)
  end,
})
