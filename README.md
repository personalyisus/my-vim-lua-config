# Neovim Configuration

Personal Neovim config built on **Neovim 0.12+** using the native `vim.pack` package manager.

## Structure

- `init.lua` — Entry point, loads core modules
- `lua/config/` — Core config: options, keymaps, autocmds
- `plugin/` — Plugin specs using `vim.pack.add()` (each file is auto-loaded)