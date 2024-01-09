return {
  { "folke/lazy.nvim", tag = "stable" },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
    },
  },

  {
    "echasnovski/mini.ai",
    opts = {
      search_method = "cover",
      silent = true,
    },
  },
}
