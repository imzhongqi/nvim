return {
  "folke/which-key.nvim",

  opts = function()
    ---@type Options
    return {
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

      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>a"] = { name = "+ai" },
        ["<leader>b"] = { name = "+buffer" },

        ["<leader>c"] = { name = "+code" },
        ["<leader>cl"] = { name = "+lsp" },

        ["<leader>f"] = { name = "+file/find" },
        ["<leader>t"] = { name = "+test" },

        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },

        ["<leader>o"] = { name = "+open" },
        ["<leader>ot"] = { name = "+Terminal" },
        ["<leader>oa"] = { name = "+AI" },
        ["<leader>od"] = { name = "+Database UI" },

        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    }
  end,
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
