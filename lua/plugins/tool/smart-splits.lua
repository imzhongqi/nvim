return {
  {
    "kwkarlwang/bufresize.nvim",
    opts = {},
  },
  {
    "mrjones2014/smart-splits.nvim",
    dependencies = {
      "kwkarlwang/bufresize.nvim",
    },
    keys = {
      {
        "<leader>ux",
        function() require("smart-splits").start_resize_mode() end,
        desc = "Start Resize Mode",
        mode = { "n" },
      },
      {
        "<C-h>",
        function() require("smart-splits").move_cursor_left() end,
        desc = "Move cursor to left",
        mode = { "n" },
      },
      {
        "<C-j>",
        function() require("smart-splits").move_cursor_down() end,
        desc = "Move cursor to down",
        mode = { "n" },
      },
      {
        "<C-k>",
        function() require("smart-splits").move_cursor_up() end,
        desc = "Move cursor to up",
        mode = { "n" },
      },
      {
        "<C-l>",
        function() require("smart-splits").move_cursor_right() end,
        desc = "Move cursor to right",
        mode = { "n" },
      },

      {
        "<M-S-h>",
        function()
          require("smart-splits").resize_left()
          require("bufresize").register()
        end,
        desc = "Resize left",
        mode = { "t", "n" },
      },
      {
        "<M-S-j>",
        function()
          require("smart-splits").resize_down()
          require("bufresize").register()
        end,
        desc = "Resize down",
        mode = { "t", "n" },
      },
      {
        "<M-S-k>",
        function()
          require("smart-splits").resize_up()
          require("bufresize").register()
        end,
        desc = "Resize up",
        mode = { "t", "n" },
      },
      {
        "<M-S-l>",
        function()
          require("smart-splits").resize_right()
          require("bufresize").register()
        end,
        desc = "Resize right",
        mode = { "t", "n" },
      },

      {
        "<leader>bsh",
        function() require("smart-splits").swap_buf_left() end,
        desc = "Move buffer to left",
        mode = { "n" },
      },
      {
        "<leader>bsj",
        function() require("smart-splits").swap_buf_down() end,
        desc = "Move buffer to down",
        mode = { "n" },
      },
      {
        "<leader>bsk",
        function() require("smart-splits").swap_buf_up() end,
        desc = "Move buffer to up",
        mode = { "n" },
      },
      {
        "<leader>bsl",
        function() require("smart-splits").swap_buf_right() end,
        desc = "Move buffer to right",
        mode = { "n" },
      },
    },
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
