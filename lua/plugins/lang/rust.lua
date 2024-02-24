return {
  { "simrat39/rust-tools.nvim", enabled = false },
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
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    version = "^3",
    lazy = true,
    priorty = 0,
    ft = { "rust" },
    opts = function()
      return {
        dap = {
          configuration = {
            type = "",
            name = "",
            request = "",
            program = "",
          },
        },
      }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },
}
