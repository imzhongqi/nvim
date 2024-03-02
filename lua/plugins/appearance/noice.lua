return {
  "folke/noice.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

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
              style = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
            },
            position = { row = 2, col = 3 },
            win_options = {
              winblend = 10,
              winhighlight = {
                Normal = "Normal",
                FloatBorder = "NoiceCmdlinePopupBorder",
              },
            },
            scrollbar = false,
          },
        },
      },
    },

    ---@type NoiceConfigViews
    views = {
      mini = {
        position = {
          row = 1,
          col = "100%",
          -- col = 0,
        },
        win_options = {
          winblend = 100,
          winhighlight = {
            Normal = "Comment",
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
      progress = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires
      },

      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
          throttle = 50,
        },
      },

      documentation = {
        view = "hover",
        ---@type NoiceViewOptions
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = {
            concealcursor = "n",
            conceallevel = 3,
          },
        },
      },
    },

    ---@type NoiceRouteConfig[]
    routes = {
      {
        view = "notify",
        filter = { event = "msg_show", kind = { "echo", "echomsg" }, find = "image" },
        opts = { replace = true },
      },

      {
        view = "mini",
        filter = { event = "msg_show", find = "DB:" },
        opts = { skip = true },
      },

      {
        view = "mini",
        filter = { event = "notify" },
        opts = { title = "[DBUI]", skip = true },
      },

      {
        view = "mini",
        filter = { event = "msg_show" },
        opts = { replace = true },
      },
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
