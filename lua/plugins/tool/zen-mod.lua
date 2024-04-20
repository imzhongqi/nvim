return {
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
    on_open = function(win) vim.wo[win].fillchars = vim.go.fillchars end,
  },
  cmd = "ZenMode",
  keys = {
    {
      "<C-w>z",
      function()
        local width = vim.v.count
        if 1 < width and width <= 10 then
          width = width / 10
        end
        local view = require "zen-mode.view"
        if view.is_open() and width > 0 then
          pcall(view.close)
          pcall(view.open, { window = { width = width } })
        else
          pcall(require("zen-mode").toggle, { window = { width = width == 0 and 1 or width } })
        end
      end,
      desc = "Enter Zen Mode",
    },
  },
  config = function(_, opts)
    require("zen-mode").setup(opts)
    local view = require "zen-mode.view"
    local close = view.close

    view.close = function()
      local status_ok = pcall(close)
      if not status_ok then
        vim.cmd(string.format("q %d", view.win))
      end
    end
  end,
}
