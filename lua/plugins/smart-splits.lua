return {
  {
    "kwkarlwang/bufresize.nvim",
    opts = {
      register = {
        trigger_events = { "BufWinEnter", "WinEnter" },
        keys = {},
      },
      resize = {
        trigger_events = {
          "VimResized",
        },
        increment = 1,
      },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    dependencies = {
      "kwkarlwang/bufresize.nvim",
    },
    event = "VeryLazy",
    keys = function()
      return {
        { "<leader>ux", require("smart-splits").start_resize_mode, desc = "Start Resize Mode", mode = { "n" } },

        { "<M-h>", require("smart-splits").move_cursor_left, desc = "Move cursor to left", mode = { "n" } },
        { "<M-j>", require("smart-splits").move_cursor_down, desc = "Move cursor to down", mode = { "n" } },
        { "<M-k>", require("smart-splits").move_cursor_up, desc = "Move cursor to up", mode = { "n" } },
        { "<M-l>", require("smart-splits").move_cursor_right, desc = "Move cursor to right", mode = { "n" } },

        { "<M-S-h>", require("smart-splits").resize_left, desc = "Resize left", mode = { "n" } },
        { "<M-S-j>", require("smart-splits").resize_down, desc = "Resize down", mode = { "n" } },
        { "<M-S-k>", require("smart-splits").resize_up, desc = "Resize up", mode = { "n" } },
        { "<M-S-l>", require("smart-splits").resize_right, desc = "Resize right", mode = { "n" } },

        { "<leader>bsh", require("smart-splits").swap_buf_left, desc = "Move buffer to left", mode = { "n" } },
        { "<leader>bsj", require("smart-splits").swap_buf_down, desc = "Move buffer to down", mode = { "n" } },
        { "<leader>bsk", require("smart-splits").swap_buf_up, desc = "Move buffer to up", mode = { "n" } },
        { "<leader>bsl", require("smart-splits").swap_buf_right, desc = "Move buffer to right", mode = { "n" } },
      }
    end,
    opts = function()
      return {
        resize_mode = {
          silent = true,
          hooks = {
            on_leave = require("bufresize").register,
          },
        },
      }
    end,
  },
}
