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
      ["view_opened"] = function()
        vim.keymap.set("n", "q", "<cmd>tabclose<cr>", { silent = true })
      end,
    },

    icons = {
      folder_closed = Icons.ui.FolderClosed,
      folder_open = Icons.ui.FolderOpen,
    },

    signs = {
      fold_closed = Icons.ui.Collapsed,
      fold_open = Icons.ui.Expanded,
      done = Icons.misc.ok,
    },
  },
}
