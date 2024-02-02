return {
  {
    "folke/zen-mode.nvim",
    opts = {
      on_open = function(win)
        vim.wo[win].fillchars = vim.go.fillchars
      end,
    },
    cmd = "ZenMode",
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufRead",
    main = "rainbow-delimiters.setup",
    submodules = false,
    opts = {},
  },

  {
    "karb94/neoscroll.nvim",
    opts = {
      -- hide_cursor = false,
      easing_function = "quadratic",
      mappings = {},
    },
    keys = function()
      local sc = require("neoscroll")
      local scroll = function(lines, move_cursor, time, easing_function, info)
        return function()
          sc.scroll(lines, move_cursor, time, easing_function, info)
        end
      end

      return {
        { "<C-u>", scroll(-vim.wo.scroll, true, 80), desc = "Scroll Up" },
        { "<C-d>", scroll(vim.wo.scroll, true, 80), desc = "Scroll Down" },
        { "<C-b>", scroll(-vim.fn.winheight(0), true, 100), desc = "Scroll Forward" },
        { "<C-f>", scroll(vim.fn.winheight(0), true, 100), desc = "Scroll Forward" },
        { "<C-y>", scroll(-0.10, false, 100), desc = "Scroll window upward in the buffer" },
        { "<C-e>", scroll(0.10, false, 100), desc = "Scroll window downward in the buffer" },
        {
          "zt",
          function()
            sc.zt(250)
          end,
        },
        {
          "zz",
          function()
            sc.zz(250)
          end,
        },
        {
          "zb",
          function()
            sc.zb(250)
          end,
        },
      }
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "BufRead",
    opts = {
      show = true,
      show_in_active_only = false,
      set_highlights = true,
      folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
      max_lines = false, -- disables if no. of lines in buffer exceeds this
      hide_if_all_visible = true, -- Hides everything if all lines are visible
      throttle_ms = 10,
      handle = {
        text = " ",
        blend = 40, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
        color = nil,
        color_nr = nil, -- cterm
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },

      excluded_buftypes = {
        "terminal",
      },

      excluded_filetypes = {
        "lazy",
        "neo-tree",
        "dashboard",
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
      },

      handlers = {
        cursor = false,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = true,
        search = false, -- Requires hlslens
        ale = false, -- Requires ALE
      },

      marks = {
        Cursor = {
          text = "-",
          priority = 0,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Normal",
        },
        Search = {
          text = { "-", "=" },
          priority = 1,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Search",
        },
        Error = {
          text = { "-", "=" },
          priority = 2,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          priority = 3,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          priority = 4,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          priority = 5,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "-", "=" },
          priority = 6,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Normal",
        },
        GitAdd = {
          text = "┆",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsAdd",
        },
        GitChange = {
          text = "┆",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsChange",
        },
        GitDelete = {
          text = "▁",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsDelete",
        },
      },
    },
  },

  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10") == 1,
    opts = {
      menu = {
        scrollbar = {
          enable = false,
          background = true,
        },
      },
    },
    config = function(_, opts)
      vim.cmd([[hi WinBar guisp=#665c54 guibg=none]])
      vim.cmd([[hi WinBarNC guisp=#665c54 guibg=none]])
      require("dropbar").setup(opts)
    end,
  },
}
