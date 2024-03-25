return {
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    opts = {
      excluded_filetypes = {
        "neo-tree",
        "dashboard",
        "db_ui",
      },
      current_only = true,
      signs_on_startup = { "diagnostics", "search", "marks" },
      signs_overflow = "right",
      winblend_gui = 40,

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
      easing_function = "quadratic",
      mappings = {},
    },
    keys = function()
      local scroll = function(lines, move_cursor, time, easing_function, info)
        return function() require("neoscroll").scroll(lines, move_cursor, time, easing_function, info) end
      end

      return {
        { "<C-u>", scroll(-vim.wo.scroll, true, 80), desc = "Scroll Up" },
        { "<C-d>", scroll(vim.wo.scroll, true, 80), desc = "Scroll Down" },
        { "<C-b>", scroll(-vim.fn.winheight(0) + 1, true, 100), desc = "Scroll Forward" },
        { "<C-f>", scroll(vim.fn.winheight(0) - 1, true, 100), desc = "Scroll Forward" },
        { "<C-y>", scroll(-0.10, false, 100), desc = "Scroll window upward in the buffer" },
        { "<C-e>", scroll(0.10, false, 100), desc = "Scroll window downward in the buffer" },
        { "zt", function() require("neoscroll").zt(250) end },
        { "zz", function() require("neoscroll").zz(250) end },
        { "zb", function() require("neoscroll").zb(250) end },
      }
    end,
  },
}
