return {
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
}
