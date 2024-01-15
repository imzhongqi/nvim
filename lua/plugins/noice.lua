return {
  "folke/noice.nvim",

  ---@type NoiceConfig
  opts = {
    presets = {
      inc_rename = {
        cmdline = {
          format = {
            IncRename = {
              title = " Rename ",
              pattern = "^:%s*IncRename%s+",
              icon = "󰤌",
              conceal = true,
              opts = {
                relative = "cursor",
                size = { min_width = 20 },
                position = { row = -2, col = 0 },
              },
            },
          },
        },
      },
      lsp_doc_border = {
        views = {
          hover = {
            border = {
              style = "rounded",
            },
            position = { row = 2, col = 3 },
            win_options = {
              winblend = 25,
            },
            scrollbar = false,
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

      cmdline_popup = {
        position = {
          row = "15%",
          col = "50%",
        },
        size = {
          min_width = 60,
          height = "auto",
          width = "auto",
        },
        win_options = {
          winblend = 20,
        },
      },

      confirm = {
        format = { "{confirm} " },
        position = {
          row = "50%",
          col = "50%",
        },
        win_options = {
          winblend = 20,
        },
      },
    },
    lsp = {
      progress = {},
    },
  },
}
