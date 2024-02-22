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
    vim.cmd([[hi WinBar guisp=#665c54 guibg=none]])
    vim.cmd([[hi WinBarNC guisp=#665c54 guibg=none]])
    require("dropbar").setup(opts)
  end,
}
