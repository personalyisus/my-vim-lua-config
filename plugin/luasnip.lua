-- NOTE: LuaSnip has an optional build step for jsregexp support.
-- After install, run the following in the plugin directory:
-- ~/.local/share/nvim/pack/github/start/LuaSnip/
--   make install_jsregexp
vim.pack.add({
  { src = gh("L3MON4D3/LuaSnip") },
  { src = gh("rafamadriz/friendly-snippets") },
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").setup({
  history = true,
  delete_check_events = "TextChanged",
})

-- Yisus note: Keybinds disabled since they cause issues with github copilot completion
-- vim.keymap.set({ "i" }, "<tab>", function()
--   return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
-- end, { expr = true, silent = true })
-- vim.keymap.set({ "s" }, "<tab>", function() require("luasnip").jump(1) end)
-- vim.keymap.set({ "i", "s" }, "<s-tab>", function() require("luasnip").jump(-1) end)
