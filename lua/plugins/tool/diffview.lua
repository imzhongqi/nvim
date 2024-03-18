return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewFileHistory",
    "DiffviewRefresh",
  },
  opts = {
    hooks = {
      ["view_opened"] = function() vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", { silent = true }) end,
    },

    icons = {
      folder_closed = _Icons.ui.FolderClosed,
      folder_open = _Icons.ui.FolderOpen,
    },

    signs = {
      fold_closed = _Icons.ui.Collapsed,
      fold_open = _Icons.ui.Expanded,
      done = _Icons.misc.ok,
    },
  },
}
