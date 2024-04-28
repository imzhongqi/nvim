return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufRead",
    main = "rainbow-delimiters.setup",
    submodules = false,
    opts = function()
      local rainbow_delimiters = require "rainbow-delimiters"
      return {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
      }
    end,
  },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          normal_hl = "Comment", -- Base highlight group in the notification window
          winblend = 80, -- Background color opacity in the notification window
          border = "none", -- Border around the notification window
          zindex = 30, -- Stacking priority of the notification window
          max_width = 0, -- Maximum width of the notification window
          max_height = 5, -- Maximum height of the notification window
          x_padding = 2, -- Padding from right edge of window boundary
          y_padding = 0, -- Padding from bottom edge of window boundary
          align = "bottom", -- How to align the notification window
          relative = "editor", -- What the notification window position is relative to
        },
      },
    },
  },

  {
    "RRethy/vim-illuminate",
    opts = {
      filetypes_denylist = {
        "dropbar_menu",
      },
      should_enable = function(bufnr) return vim.bo[bufnr].buftype == "" end,
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "dbui",
        },
      },
    },
    main = "ibl",
  },

  {
    "echasnovski/mini.indentscope",
    enabled = false,
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "dbui",
          "fzf",
        },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },
}
