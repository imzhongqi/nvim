return {
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
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },

  {
    "RRethy/vim-illuminate",
    opts = {
      filetypes_denylist = {
        "dropbar_menu",
      },
    },
  },
}
