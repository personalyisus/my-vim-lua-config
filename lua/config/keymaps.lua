-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<space>w", ":w<cr>")
map("n", "<space>q", ":q<CR>")
map("n", "<leader>q", ":q<CR>")

-- tab creation and movement
map("n", "<S-l>", ":tabn<CR>")
map("n", "<S-h>", ":tabp<CR>")
map("n", "<C-n>", ":tabe<CR>")

-- based on https://www.lazyvim.org/configuration/general#keymaps

-- for windows creation just do C-W_v C-W_s and C-W_q, last one to quit

-- windows navigation, see :h window-move-cursor

map("n", "<C-j>", ":wincmd j<cr>")
map("n", "<C-l>", ":wincmd l<cr>")
map("n", "<C-h>", ":wincmd h<cr>")
map("n", "<C-k>", ":wincmd k<cr>")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })


-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map({ "n", "v" }, "<leader>lf", function()
  vim.lsp.buf.format()
end, { desc = "Format" })


-- For LSP hover information
map("n", "K", function()
  vim.lsp.buf.hover();
end, { desc = "Show lsp hover information" })