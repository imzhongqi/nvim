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
      item = { Icons.ui.Collapsed, Icons.ui.Expanded },
      section = { Icons.ui.Collapsed, Icons.ui.Expanded },
    },
  },
  config = true,
}
