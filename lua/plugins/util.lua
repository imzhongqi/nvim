return {
  {
    "nmac427/guess-indent.nvim",
    opts = { auto_cmd = true },
    event = "VeryLazy",
  },

  {
    "gbprod/stay-in-place.nvim",
    event = "VeryLazy",
    config = true,
  },

  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    opts = {},
  },

  {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    opts = {},
  },

  {
    "keaising/im-select.nvim",
    event = "InsertEnter",
    opts = {
      default_im_select = "com.apple.keylayout.US",
      default_command = "/usr/local/bin/im-select",
      set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
      set_previous_events = { "InsertEnter" },
      keep_quiet_on_no_binary = false,
      async_switch_im = true,
    },
    enabled = vim.fn.executable("im-select") == 1,
  },

  {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 1001,
    opts = {
      window = {
        open = "alternate",
      },
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        mode = "foreground",
      },
    },
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
  },
}
