return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.3",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    -- We cache the results of "git rev-parse"
    -- Process creation is expensive in Windows, so this reduces latency
    local is_inside_work_tree = {}

    project_files = function()
      local opts = {} -- define here if you want to define something

      local cwd = vim.fn.getcwd()
      if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
      end

      if is_inside_work_tree[cwd] then
        builtin.git_files(opts)
      else
        builtin.find_files(opts)
      end
    end

    require("telescope").load_extension("fzf")

    vim.keymap.set("n", "<leader>ff", project_files, { desc = "Find files in project" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep in project" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
  end,
}
