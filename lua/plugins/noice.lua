return {
  "folke/noice.nvim",

  ---@type NoiceConfig
  opts = {
    cmdline = {
      enabled = true, -- enables the Noice cmdline UI
      view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      opts = {}, -- global options for the cmdline. See section on views
      ---@type table<string, CmdlineFormat>
      format = {
        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        cmdline = { title = "" },
        search_down = { title = "" },
        search_up = { title = "" },
        filter = { title = "" },
        lua = { title = "" },
        help = { title = "" },
        input = {}, -- Used by input()
        -- lua = false, -- to disable a format, set to `false`
      },
    },
    presets = {
      inc_rename = {
        cmdline = {
          format = {
            IncRename = {
              title = "",
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
              winblend = 0,
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
          winblend = 0,
        },
      },

      confirm = {
        format = { " {confirm} " },
        position = {
          row = "50%",
          col = "50%",
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
          text = {
            top = "",
          },
        },
        win_options = {
          winblend = 0,
        },
      },
    },
    lsp = {
      progress = {},
    },
  },

  keys = function()
    return {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<leader>snd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
      },
    }
  end,
}
