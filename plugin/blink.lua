vim.pack.add({
  { src = gh("saghen/blink.cmp"), version = "v1.10.2" },
})

require("blink.cmp").setup({
  keymap = {
    preset = "super-tab",
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "accept", "fallback" },
  },
  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = {
      download = true,
    },
  },
  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    nerd_font_variant = "mono",
  },
  -- Yisusnote: Using manual completion list selection
  -- as noted in https://cmp.saghen.dev/configuration/completion.html#list
  -- since it got annoying trying to find something via / and then
  -- the list automatically opens and auto selects an item
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
  },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = false,
    },
  },
})
