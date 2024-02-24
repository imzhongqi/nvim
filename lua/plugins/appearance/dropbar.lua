return {
  "Bekaboo/dropbar.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  event = "LazyFile",
  enabled = vim.fn.has("nvim-0.10") == 1,
  opts = {
    menu = {
      scrollbar = {
        enable = false,
        background = true,
      },
    },
  },
  config = function(_, opts)
    require("dropbar").setup(opts)
  end,
}
