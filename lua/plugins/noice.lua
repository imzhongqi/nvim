return {
  "folke/noice.nvim",

  ---@type NoiceConfig
  opts = {
    ---@type NoiceConfigViews
    views = {
      mini = {
        win_options = {
          winbar = "",
          foldenable = false,
          winblend = 60,
          winhighlight = {
            -- Normal = "NoiceMini",
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
