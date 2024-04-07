return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = function()
      return {
        { [[<C-\>]] },
      }
    end,
    opts = {
      -- size = function(term)
      --   if term.direction == "horizontal" then
      --     return 10
      --   elseif term.direction == "vertical" then
      --     return vim.o.columns * 0.4
      --   end
      -- end,
      open_mapping = [[<C-\>]],
      direction = "horizontal",
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
