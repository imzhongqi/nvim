return {
  -- {
  --   "nmac427/guess-indent.nvim",
  --   opts = { auto_cmd = true },
  --   event = "VeryLazy",
  -- },

  { "tpope/vim-sleuth", event = "LazyFile" },

  -- {
  --   "gbprod/stay-in-place.nvim",
  --   event = "LazyFile",
  --   config = true,
  -- },

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

  -- {
  --   "tzachar/highlight-undo.nvim",
  --   event = "VeryLazy",
  --   config = true,
  -- },

  {
    "krady21/compiler-explorer.nvim",
    config = true,
    cmd = {
      "CECompile",
      "CECompileLive",
    },
  },

  {
    "keaising/im-select.nvim",
    event = "VeryLazy",
    opts = {
      default_im_select = "com.apple.keylayout.ABC",
      default_command = "im-select",
      set_default_events = { "FocusGained", "InsertLeave", "CmdlineLeave" },
      set_previous_events = {
        -- "InsertEnter",
      },
      keep_quiet_on_no_binary = false,
      async_switch_im = true,
    },
    enabled = vim.fn.executable "im-select" == 1,
  },

  {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 1001,
    opts = {
      window = { open = "alternate" },
      -- nest_if_no_args = true,
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
      "UndotreeShow",
      "UndotreeHide",
      "UndotreePersistUndo",
    },
    keys = {
      {
        "<leader>mu",
        vim.cmd.UndotreeToggle,
        desc = "Toggle Undotree",
      },
    },
    opts = {
      HelpLine = 0,
      DiffAutoOpen = 0,
      HighlightChangedWithSign = 0,
      TreeNodeShape = "",
    },
    config = function(_, opts)
      for k, v in pairs(opts) do
        vim.g["undotree_" .. k] = v
      end
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = vim.opt.sessionoptions:get(),
      pre_save = function() vim.cmd [[ UndotreeHide ]] end,
    },
    keys = function()
      return {
        { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
        { "<leader>ql", function() require("persistence").load { last = true } end, desc = "Restore Last Session" },
        { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
      }
    end,
  },

  {
    "cbochs/portal.nvim",
    event = "LazyFile",
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

  {
    "mikesmithgh/kitty-scrollback.nvim",
    cmd = {
      "KittyScrollbackGenerateKittens",
      "KittyScrollbackCheckHealth",
    },
    event = { "User KittyScrollbackLaunch" },
    opts = {
      {
        paste_window = {
          winopts_overrides = function(winopts)
            winopts.border = {
              "╭",
              "─",
              "╮",
              "│",
              "┤",
              "─",
              "├",
              "│",
            }
            return winopts
          end,
          footer_winopts_overrides = function(winopts)
            winopts.border = {
              "│",
              " ",
              "│",
              "│",
              "╯",
              "─",
              "╰",
              "│",
            }
            return winopts
          end,
        },
      },
    },
  },
}
