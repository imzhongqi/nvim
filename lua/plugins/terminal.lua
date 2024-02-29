return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = function()
      local util = require("lazyvim.util")
      local lazygit_toggle = function(root)
        local Terminal = require("toggleterm.terminal").Terminal
        return function()
          local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = root and util.root() or nil,
            hidden = true,
            close_on_exit = true,
            direction = "float",
            float_opts = {
              border = "none",
              width = 100000,
              height = 100000,
            },
            on_open = function(_)
              vim.cmd("startinsert!")
            end,
            on_close = function(_) end,
            count = 99,
          })
          lazygit:toggle()
        end
      end

      return {
        { [[<C-\>]] },
        -- { "<leader>gg", lazygit_toggle(true), desc = "Lazygit (root)" },
        -- { "<leader>gG", lazygit_toggle(), desc = "Lazygit (cwd)" },
      }
    end,
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      direction = "float",
      -- start_in_insert = true,
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      float_opts = {
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = "curved",
        winblend = 0,
      },
    },
  },
}
