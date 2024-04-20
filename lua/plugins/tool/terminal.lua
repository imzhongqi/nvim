return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermSelect", "TermExec" },
    keys = function()
      return {
        { [[<C-,>]] },
        {
          "<leader>ott",
          "<cmd>ToggleTerm direction=horizontal<cr>",
          desc = "Terminal (horizontal)",
        },
        {
          "<leader>otv",
          "<cmd>ToggleTerm direction=vertical<cr>",
          desc = "Terminal (vertical)",
        },
        {
          "<leader>otf",
          "<cmd>ToggleTerm direction=float<cr>",
          desc = "Terminal (float)",
        },
        {
          "<leader>ft",
          function()
            local filepath = vim.fn.expand "%:h"
            if not require("plenary.path"):new(filepath):is_dir() then
              return
            end
            require("toggleterm.terminal").Terminal:new({ dir = filepath }):toggle()
          end,
          desc = "Open terminal in current file directory",
        },
      }
    end,

    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 10
        elseif term.direction == "vertical" then
          return 40
        end
      end,
      on_create = function()
        local keymaps = {
          { "t", "<esc>", [[<C-\><C-n>]] },
          { "t", "<C-h>", [[<cmd>wincmd h<CR>]] },
          { "t", "<C-j>", [[<cmd>wincmd j<CR>]] },
          { "t", "<C-k>", [[<cmd>wincmd k<CR>]] },
          { "t", "<C-l>", [[<cmd>wincmd l<CR>]] },
          { "t", "<C-w>", [[<C-\><C-n><C-w>]] },
        }

        vim.g.toggleterm_keymap_loaded = vim.g.toggleterm_keymap_loaded or true

        local toggle_keymap = function(set)
          return function(opts)
            if set then
              for _, keymap in pairs(keymaps) do
                vim.keymap.set(keymap[1], keymap[2], keymap[3], opts)
              end
            else
              for _, keymap in pairs(keymaps) do
                vim.keymap.del(keymap[1], keymap[2], opts)
              end
            end
          end
        end

        vim.keymap.set({ "t", "n" }, "<c-w>", [[<C-\><C-n><C-w>]], { buffer = 0, desc = "Esc" })
        vim.keymap.set({ "t", "n" }, [[<C-\><C-\>]], function()
          vim
            .iter(require("toggleterm.terminal").get_all())
            :map(function(t) return { buffer = t.bufnr } end)
            :each(toggle_keymap(not vim.g.toggleterm_keymap_loaded))
          vim.g.toggleterm_keymap_loaded = not vim.g.toggleterm_keymap_loaded
        end, { buffer = 0, desc = "Toggle terminal keymap" })

        if vim.g.toggleterm_keymap_loaded then
          toggle_keymap(true) { buffer = 0 }
        end
      end,
      open_mapping = [[<c-,>]],
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
