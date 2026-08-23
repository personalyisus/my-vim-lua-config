vim.pack.add({
  { src = gh("folke/snacks.nvim") },
})

require("snacks").setup({})

-- Toggle the profiler
Snacks.toggle.profiler():map("<leader>pp")
-- Toggle the profiler highlights
Snacks.toggle.profiler_highlights():map("<leader>ph")

vim.keymap.set("n", "<leader>ps", function()
  Snacks.profiler.scratch()
end, { desc = "Profiler Scratch Buffer" })
