return {
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      -- hide_cursor = false,
    },
    config = function(_, opts)
      require("neoscroll").setup(opts)

      local mappings = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } }
      mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } }
      mappings["<C-b>"] = { "scroll", { "-vim.fn.winheight(0)", "true", "160" } }
      mappings["<C-f>"] = { "scroll", { "vim.fn.winheight(0)", "true", "160" } }
      mappings["<C-y>"] = { "scroll", { "-0.10", "false", "50" } }
      mappings["<C-e>"] = { "scroll", { "0.10", "false", "50" } }
      mappings["zt"] = { "zt", { "250" } }
      mappings["zz"] = { "zz", { "250" } }
      mappings["zb"] = { "zb", { "250" } }

      require("neoscroll.config").set_mappings(mappings)
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    opts = {
      show = true,
      show_in_active_only = false,
      set_highlights = true,
      folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
      max_lines = false, -- disables if no. of lines in buffer exceeds this
      hide_if_all_visible = true, -- Hides everything if all lines are visible
      throttle_ms = 10,
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
        cursor = true,
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
}
