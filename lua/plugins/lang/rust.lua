return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
  },
}
