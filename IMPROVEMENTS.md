# Neovim Configuration Analysis

## Dead Code Removed ✅

The following dead/stale code was removed:

1. **`init.lua`** — Removed 70+ lines of commented-out lazy.nvim bootstrap and setup code, stale profiler config referencing `lazy/` paths, commented-out `vim.pack.add` blocks, and `mapleader`/`maplocalleader` declarations that were duplicating `options.lua`.

2. **`lua/plugins/` directory** — Removed all 18 stub files that only contained `-- migrated to plugin/X.lua` + `return {}`. These were leftovers from the lazy.nvim → vim.pack migration and served no purpose since lazy.nvim is no longer active.

3. **`lua/plugins/example.lua`** — Removed the 270-line LazyVim example spec template containing configs for plugins you don't use (gruvbox, symbols-outline, nvim-cmp, telescope, etc.).

4. **`lua/config/lazy.lua`** — Removed entirely. This was the old lazy.nvim setup file that's no longer required.

5. **`lua/config/init.lua`** — Removed empty file (0 bytes).

6. **`lua/plugins/conform-nvim.lua`** — Removed empty file (0 bytes).

7. **`lazy-lock.json`** — Removed stale lock file from when lazy.nvim was used.

8. **`plugin/fzf-lua.lua`** — Removed commented-out lazy.nvim return block at the bottom.

9. **`plugin/mason.lua`** — Removed commented-out lazy.nvim spec block at the bottom.

10. **`keymaps.lua`** — Removed duplicate `<space>q` mapping (identical to `<leader>q` since leader is space), removed stale "Prettier" comment block, fixed typos "signture" → "signature", "Navitate" → "Navigate", "closes" → "closest", "kua config" → "nvim config", removed stale LazyVim header comment.

11. **`autocmds.lua`** — Changed augroup prefix from `lazyvim_` to `config_` since LazyVim is not used.

12. **`options.lua`** — Removed stale LazyVim header comment, removed `vim.g.copilot_assume_mapped` (copilot not installed), added `maplocalleader` setting, updated header comment.

---

## Bugs Found & Fixed ✅

| Bug | File | Fix |
|---|---|---|
| Typo `lsp_fallack` | `keymaps.lua` | Changed to `lsp_fallback` |
| Typo "Navitate" (×4) | `keymaps.lua` | Changed to "Navigate" |
| Typo "signture" | `keymaps.lua` | Changed to "signature" |
| Typo "closes found test" | `keymaps.lua` | Changed to "closest found test" |
| Typo "kua config" | `keymaps.lua` | Changed to "nvim config" |
| Deprecated `vim.loop.cwd()` | `neo-tree.lua` | Changed to `vim.uv.cwd()` |
| Inconsistent API `nvim_set_keymap` | `hop.lua` | Changed to `vim.keymap.set` |
| Duplicate `mapleader` set twice | `init.lua` + `options.lua` | Removed from `init.lua` |
| Duplicate `<space>q` / `<leader>q` | `keymaps.lua` | Consolidated to `<leader>q` |

---

## Potential Improvements & Suggestions

### 🔴 High Priority

1. **Keymap conflicts between `keymaps.lua` and `fzf-lua.lua`**
   - `<leader>gd` → `vim.lsp.buf.definition()` (keymaps.lua) AND `fzf-lua.lsp_definitions` (fzf-lua.lua)
   - `<leader>gr` → `vim.lsp.buf.references()` (keymaps.lua) AND `fzf-lua.lsp_references` (fzf-lua.lua)
   - `<leader>gt` → `vim.lsp.buf.type_definition()` (keymaps.lua) vs `<leader>ft` → `fzf_lua.lsp_typedefs` (fzf-lua.lua)
   - **Suggestion**: Decide which you prefer (native LSP vs fzf-lua) and remove the duplicates. fzf-lua gives you a navigable list; native LSP jumps directly. Consider using one consistently or using different key prefixes.

2. **`<C-n>` keymap conflict**
   - `keymaps.lua` maps `<C-n>` to `:$tabe<CR>` (new tab)
   - `blink.lua` maps `<C-n>` to `select_next` in completion
   - These won't conflict in practice (one is in insert mode for blink, one in normal), but `<C-n>` is also the default Vim "down" motion. Consider whether `:tabe` on `<C-n>` is what you actually want.

3. **Keymaps referencing plugins that may not be loaded yet**
   - `keymaps.lua` calls `require("conform")`, `require("neotest")` in keymaps — these will error if the plugin isn't loaded yet. Consider wrapping in `pcall` or using lazy-loading patterns where the keymaps are defined alongside the plugin (as you already do in fzf-lua, neo-tree, trouble, etc.).
   - The keymaps for `Gitsigns`, `neotest`, and `conform` in `keymaps.lua` should ideally be moved to their respective `plugin/*.lua` files.

### 🟡 Medium Priority

4. **`hardtime.nvim` with `disabled_keys = {}`**
   - Setting `disabled_keys = {}` means hardtime won't restrict *any* keys, which somewhat defeats its purpose. If you want hardtime for the hints/reports only, that's fine — but verify this is intentional.

5. **`snacks.nvim` is loaded unconditionally at startup**
   - `snacks.lua` does `require("snacks").setup({})` and sets up profiler keymaps on every startup, even though you likely only need it when profiling. Consider lazy-loading it or gating the keymaps behind a check.

6. **`copilot_assume_mapped = true` is set but no copilot plugin is installed**
   - This was presumably for github-copilot.vim which is no longer in your config. It's harmless but confusing — removed in this cleanup.

7. **`lua_ls` missing from `mason-lspconfig` `ensure_installed` list**
   - Your treesitter parsers include `lua` and you have `stylua` in mason's `ensure_installed`, but `lua_ls` isn't in `mason-lspconfig`'s `ensure_installed`. Consider adding it.

8. **Missing LSP keymaps for `gl` / hover alternative**
   - You have `K` for hover + signature help, but `<leader>cd` for diagnostics. Consider adding `<leader>ca` for code actions (`vim.lsp.buf.code_action()`) — it's a common and useful mapping.

9. **`conform-nvim.lua` lists `jsonls` as a formatter**
   - `jsonls` is an LSP server, not a standalone formatter. In conform, you'd want to use it via `lsp_fallback` (which you already have in your keymaps), not as a direct formatter entry. The `jsonc` filetype entry is fine since you removed the treesitter parser — but if you add `jsonc` filetype support back, you'll want the formatter.

10. **`options.lua` sets `vim.g.wrap = "nowrap"`**
    - `vim.g.wrap` is a string `"nowrap"`, but `wrap` is a boolean option. It should be `vim.opt.wrap = false` or `vim.opt.nowrap = true`. The current form may not actually disable wrapping.

### 🟢 Low Priority / Style

11. **Mixed `mapleader` conventions**
    - Some keymaps use `<space>X>` and others use `<leader>X>`. Since your leader is space, these are identical. Pick one style and be consistent — `<leader>X>` is more explicit and clear.

12. **Stale LazyVim references in comments**
    - Several files still reference LazyVim in comments. These have been cleaned up in the changed files, but watch for any remaining mental model drift.

13. **`blink.lua` has `<Tab>` mapped to accept**
    - You have `<Tab>` = accept + fallback, and `<CR>` = accept + fallback. Having both is fine but means you can't use `<Tab>` for snippet navigation. The luasnip keymaps for `<Tab>` are commented out because of this — consider whether you want snippet jump functionality.

14. **Neotest keymaps but no neotest plugin**
    - `keymaps.lua` references `require("neotest")` but there's no neotest plugin in your `plugin/` configs. These keymaps will error when pressed. Add neotest to your plugins or remove the keymaps.

15. **`dashboard-nvim` logo has trailing whitespace**
    - The ASCII art logo in `dashboard-nvim.lua` has inconsistent indentation. Not functionally broken, but could be trimmed for cleanliness.

16. **Consider adding `which-key` descriptions for tab keymaps**
    - The `<leader>t*` keymaps (tn, tN, ts, tS, tl, th) don't have `{ desc = }` descriptions, so they won't show nicely in which-key.

17. **`vim.g.maplocalleader = "\\"` was missing**
    - This was previously only set in the now-removed lazy.nvim section of `init.lua`. It's been added back to `options.lua`.

---

## Architecture Observations

- **Migrated from lazy.nvim to vim.pack**: You've fully migrated to Neovim 0.12's native `vim.pack`. All plugin files are in `plugin/` and use `vim.pack.add()`. This is clean and modern.
- **Dual keymap locations**: Some keymaps live in `lua/config/keymaps.lua` while plugin-specific ones are in `plugin/*.lua`. Consider consolidating — either put all keymaps in the plugin files (co-locating with the plugin they depend on) or centralize all in `keymaps.lua`. The current split makes it hard to find where a keymap is defined.
- **No lazy-loading**: All plugins in `plugin/` load eagerly at startup. This is fine for now but as your config grows, consider using `vim.pack.add()`'s lazy features or moving to filetype/load-event based loading for heavier plugins.