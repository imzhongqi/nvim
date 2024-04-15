return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    {
      "<leader>os",
      "<cmd>Outline<CR>",
      desc = "Toggle Symbol Outline",
    },
  },
  opts = {
    symbol_folding = {
      auto_unfold = {
        only = 2,
      },
    },
    preview_window = {
      live = true,
    },
    symbols = {
      icon_source = "lspkind",
    },
  },
}
