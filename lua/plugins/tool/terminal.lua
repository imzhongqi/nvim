return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = function()
      return {
        { [[<C-\>]] },
        {
          "<leader>ft",
          function()
            local filepath = vim.fn.expand "%:h"
            if not require("plenary.path"):new(filepath):is_dir() then
              return
            end
            require("toggleterm.terminal").Terminal:new({ dir = filepath }):toggle()
          end,
          desc = "Open file in terminal",
        },
      }
    end,

    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 10
        elseif term.direction == "vertical" then
          return 100
        end
      end,
      on_create = function() vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0 }) end,
      open_mapping = [[<c-\>]],
      direction = "horizontal",
      shade_terminals = false,
      -- shading_factor = -10,
      -- start_in_insert = false,
      -- insert_mappings = false,
      persist_size = false,
      close_on_exit = true,
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
