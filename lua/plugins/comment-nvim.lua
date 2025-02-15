return {
  "numToStr/Comment.nvim",
  event = { "BufRead" },
  -- options based on https://github.com/numToStr/Comment.nvim?tab=readme-ov-file#configuration-optional
  opts = {
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
  },
}
