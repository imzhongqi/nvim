return {
  {
    "kevinhwang91/nvim-fundo",
    lazy = false, -- note: this plugin is not lazy loaded
    opts = {},
    build = function() require("fundo").install() end,
  },

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
        "<leader>ou",
        "<cmd>UndotreeToggle<CR>",
        desc = "Toggle Undotree",
      },
    },
    opts = {
      HelpLine = 0,
      DiffAutoOpen = 1,
      SetFocusWhenToggle = 1,
      WindowLayout = 2,
      HighlightChangedWithSign = 0,
      TreeNodeShape = "",
      SplitWidth = 24,
    },
    config = function(_, opts)
      for k, v in pairs(opts) do
        vim.g["undotree_" .. k] = v
      end
    end,
  },
}
