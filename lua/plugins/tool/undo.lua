return {
  {
    "mbbill/undotree",
    cmd = {
      "UndotreeToggle",
      "UndotreeFocus",
      "UndotreeShow",
      "UndotreeHide",
      "UndotreePersistUndo",
    },
    keys = {
      {
        "<leader>muu",
        "<cmd>UndotreeToggle<CR>",
        desc = "Toggle Undotree",
      },
      {
        "<leader>mup",
        "<cmd>UndotreePersistUndo<CR>",
        desc = "Undotree Persist Undo",
      },
    },
    opts = {
      HelpLine = 0,
      DiffAutoOpen = 0,
      HighlightChangedWithSign = 0,
      TreeNodeShape = "",
      UndoDir = vim.fn.stdpath "cache" .. "/undodir",
    },
    config = function(_, opts)
      for k, v in pairs(opts) do
        vim.g["undotree_" .. k] = v
      end
    end,
  },

  {
    "kevinhwang91/nvim-fundo",
    event = "VeryLazy",
    opts = {},
    build = function() require("fundo").install() end,
  },
}
