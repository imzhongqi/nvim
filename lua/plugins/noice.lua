return {
  "folke/noice.nvim",

  ---@type NoiceConfig
  opts = {
    presets = {
      inc_rename = true,
      lsp_doc_border = {
        views = {
          hover = {
            border = {
              style = "rounded",
            },
            position = { row = 2, col = 3 },
          },
        },
      },
    },

    ---@type NoiceConfigViews
    views = {
      mini = {
        win_options = {
          winbar = "",
          foldenable = false,
          winblend = 60,
          winhighlight = {
            Normal = "NoiceMini",
            IncSearch = "",
            CurSearch = "",
            Search = "",
          },
        },
      },
    },
    lsp = {
      progress = {},
    },
  },
}
