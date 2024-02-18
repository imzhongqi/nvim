return {
  -- {
  --   "nmac427/guess-indent.nvim",
  --   opts = { auto_cmd = true },
  --   event = "VeryLazy",
  -- },

  { "tpope/vim-sleuth", event = "LazyFile" },

  {
    "gbprod/stay-in-place.nvim",
    event = "LazyFile",
    config = true,
  },

  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    opts = {},
  },

  {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
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
      window = { open = "alternate" },
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    opts = {
      user_default_options = {
        mode = "foreground",
      },
    },
  },
  {
    "mbbill/undotree",
    cmd = {
      "UndotreeToggle",
      "UndotreeFocus",
      "UndotreePersistUndo",
    },
    keys = {
      {
        "<leader>uu",
        vim.cmd.UndotreeToggle,
        desc = "Undotree Toggle",
      },
    },
  },

  {
    "cbochs/portal.nvim",
    event = "VeryLazy",
    dependencies = {
      "cbochs/grapple.nvim",
      "ThePrimeagen/harpoon",
    },
    keys = {
      { "<leader>o", "<cmd>Portal jumplist backward<cr>", desc = "Portal jumplist backward" },
      { "<leader>i", "<cmd>Portal jumplist forward<cr>", desc = "Portal jumplist forward" },
    },
    opts = {},
  },
}
