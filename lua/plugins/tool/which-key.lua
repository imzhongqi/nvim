return {
  "folke/which-key.nvim",

  opts = {
    window = {
      winblend = 20,
    },

    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },

    plugins = {
      spelling = true,
      presets = {
        nav = false,
      },
    },
    spec = {
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>a", group = "ai" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>cl", group = "lsp" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>o", group = "open" },
        { "<leader>oa", group = "AI" },
        { "<leader>od", group = "Database UI" },
        { "<leader>ot", group = "Terminal" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "test" },
        { "<leader>u", group = "ui" },
        { "<leader>w", group = "windows" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
      },
    },
  },
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
  end,
}
