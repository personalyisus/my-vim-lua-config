-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<space>w", ":w<cr>")
map("n", "<space>q", ":q<CR>", { desc = "Quit neovim" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit neovim" })

-- tab creation and movement
-- I'm using :$tabe so I always open new tabs after the last one,
-- so it helps with my mental organization
map("n", "<S-l>", ":tabn<CR>")
map("n", "<S-h>", ":tabp<CR>")
map("n", "<C-n>", ":$tabe<CR>")

-- EXPERIMENTAL, MAYBE I WONT LIKE THIS:

map("n", "<leader>tn", ":$tabe<CR>") -- (t)ab: open (n)ew
map("n", "<leader>ts", ":$tab split<CR>") -- (t)ab: open (s)ame
map("n", "<leader>tl", ":tabmove +1<CR>") -- (t)ab: move (l)ight (lmao)
map("n", "<leader>th", ":tabmove -1<CR>") -- (t)ab: move (h)eft (rofl)

-- clearing highlights, based on lunarvim defaults

map("n", "<leader>h", ":nohl<CR>")
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

-- Shortcuts to open the location and quickfix list
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

map({ "n", "v" }, "<leader>lf", function()
  require("conform").format()
  -- previous configuration with normal format and Prettier command
  -- vim.lsp.buf.format()
  -- vim.cmd("Prettier")
end, { desc = "Format current buffer" })

-- for diagnostics
map({ "n", "v" }, "<leader>cd", function()
  vim.diagnostic.open_float()
end, { desc = "Show current line diagnostics" })

-- For LSP hover information
map("n", "K", function()
  -- Also displays signture help for symbols which allow it
  vim.lsp.buf.signature_help()
  vim.lsp.buf.hover()
end, { desc = "Show lsp hover information" })

-- traversing to definition, declaration, type definitions..

map("n", "<leader>gt", function()
  vim.lsp.buf.type_definition()
end, { desc = "Navitate to the type definition" })

map("n", "<leader>gd", function()
  vim.lsp.buf.definition()
end, { desc = "Navitate to the definition" })

map("n", "<leader>gi", function()
  vim.lsp.buf.implementation()
end, { desc = "Navitate to the symbol's implementation" })

map("n", "<leader>gr", function()
  vim.lsp.buf.references()
end, { desc = "Navitate to the symbol's references" })
-- Renaming??
map("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end, { desc = "Rename the symbol under the cursor" })

-- Close Dashboard.nvim and edit my kua config (kinda) Suggested by Chatgpt
-- keys based on the go to config of lunarvim
map("n", "<leader>Lc", function()
  vim.cmd("cd ~/.config/nvim")
  vim.cmd("edit ~/.config/nvim/init.lua")
  vim.cmd("Neotree")
end)

-- Some Gitsigns mappings

map("n", "<leader>cb", ":Gitsigns blame_line<CR>", { desc = "View blame of line under cursor" })
