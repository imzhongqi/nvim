return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 1, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      on_open = function(win)
        vim.wo[win].fillchars = vim.go.fillchars
      end,
    },
    cmd = "ZenMode",
    keys = {
      {
        "<leader>zz",
        "<cmd>ZenMode<CR>",
        desc = "Enter Zen Mode",
      },
    },
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufRead",
    main = "rainbow-delimiters.setup",
    submodules = false,
    opts = function()
      local rainbow_delimiters = require("rainbow-delimiters")
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
    "luukvbaal/statuscol.nvim",
    event = "BufReadPost",
    branch = "0.10",
    opts = function()
      local builtin = require("statuscol.builtin")

      local nu = function(args)
        return args.nu
      end

      return {
        relculright = true,
        bt_ignore = { "terminal" },
        ft_ignore = { "neo-tree" },
        setopt = true,
        segments = {
          {
            sign = { name = { "Dap*" }, auto = true },
            click = "v:lua.ScSa",
          },
          {
            sign = {
              name = { ".*" },
              text = { ".*" },
              namespace = { ".*" },
            },
            click = "v:lua.ScSa",
          },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          {
            sign = {
              namespace = { "git" },
              colwidth = 1,
            },
            condition = { nu },
            click = "v:lua.ScSa",
          },
          {
            text = {
              function(args)
                args.fold.close = ""
                args.fold.open = ""
                args.fold.sep = " "

                return builtin.foldfunc(args)
              end,
              " ",
            },
            condition = { nu, builtin.not_empty },
            click = "v:lua.ScFa",
          },
        },
      }
    end,
  },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
}
