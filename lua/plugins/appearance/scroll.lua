return {
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    opts = {
      folds = 1000,
      excluded_filetypes = {
        "neo-tree",
        "dashboard",
        "db_ui",
      },
      current_only = true,
      signs_on_startup = { "diagnostics", "search", "marks" },
      signs_overflow = "right",
      winblend_gui = 50,

      diagnostics_severities = {
        vim.diagnostic.severity.HINT,
        vim.diagnostic.severity.ERROR,
      },
      diagnostics_info_symbol = _Icons.diagnostics.Info,
      diagnostics_hint_symbol = _Icons.diagnostics.Hint,
      diagnostics_warn_symbol = _Icons.diagnostics.Warn,
      diagnostics_error_symbol = _Icons.diagnostics.Error,
    },
  },
  {
    "karb94/neoscroll.nvim",
    opts = {
      -- hide_cursor = false,
      stop_eof = true,
      easing_function = "quadratic",
      mappings = {},
    },
    keys = function()
      local scroll = function(lines, move_cursor, time, easing_function, info)
        return function() require("neoscroll").scroll(lines(), move_cursor, time, easing_function, info) end
      end

      return {
        {
          "<C-u>",
          scroll(function() return -vim.wo.scroll end, true, 80),
          desc = "Scroll Up",
        },
        {
          "<C-d>",
          scroll(function() return vim.wo.scroll end, true, 80),
          desc = "Scroll Down",
        },
        {
          "<C-b>",
          scroll(function() return -vim.fn.winheight(0) + 1 end, true, 100),
          desc = "Scroll Forward",
        },
        {
          "<C-f>",
          scroll(function() return vim.fn.winheight(0) - 1 end, true, 100),
          desc = "Scroll Forward",
        },

        {
          "<C-y>",
          scroll(function() return -0.10 end, false, 100),
          desc = "Scroll window upward in the buffer",
        },
        {
          "<C-e>",
          scroll(function() return 0.10 end, false, 100),
          desc = "Scroll window downward in the buffer",
        },
        {
          "zt",
          function() require("neoscroll").zt(250) end,
        },
        {
          "zz",
          function() require("neoscroll").zz(250) end,
        },
        {
          "zb",
          function() require("neoscroll").zb(250) end,
        },
      }
    end,
  },
}
