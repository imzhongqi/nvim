return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
  },
  cmd = {
    "Neogit",
  },
  keys = {
    { "<leader>gu", "<cmd>Neogit<CR>", desc = "Open Neogit" },
  },
  opts = {
    signs = {
      -- { CLOSED, OPENED }
      hunk = { "", "" },
      item = { "", "" },
      -- buffers = "  ",
      -- db = "  󰆼",
      section = { "", "" },
    },
  },
  config = true,
}
