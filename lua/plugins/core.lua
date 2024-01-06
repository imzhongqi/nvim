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
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
}
