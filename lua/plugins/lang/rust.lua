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
    opts = function()
      return {
        tools = {
          hover_actions = {
            replace_builtin_hover = true,
            max_width = 80,
            max_height = 40,
          },
        },
      }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },
}
