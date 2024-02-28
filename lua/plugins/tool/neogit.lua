return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "Neogit",
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit cwd=%:p:h<CR>", desc = "Open Neogit (root)" },
    { "<leader>gG", "<cmd>Neogit<CR>", desc = "Open Neogit(cwd)" },
  },
  opts = {
    signs = {
      hunk = { "", "" },
      item = { _Icons.ui.Collapsed, _Icons.ui.Expanded },
      section = { _Icons.ui.Collapsed, _Icons.ui.Expanded },
    },
  },
  config = true,
}
