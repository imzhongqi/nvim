return {
  "ghostbuster91/nvim-next",
  event = "VeryLazy",
  config = function()
    local next = require "nvim-next"
    local builtins = require "nvim-next.builtins"

    next.setup {
      default_mappings = {
        enable = true,
        repeat_style = "original",
      },
      items = {
        builtins.f,
        builtins.t,
      },
    }

    local integrations = require "nvim-next.integrations"
    local diag = integrations.diagnostic()
    local nqf = integrations.quickfix()
    local move = require "nvim-next.move"
    local move_fn = function(cmd)
      local fn = cmd
      if type(cmd) == "string" then
        fn = function() vim.cmd(cmd) end
      end
      return function() fn() end
    end

    require("util").keymaps_set {
      { "[d", diag.goto_prev(), desc = "Previous diagnostic" },
      { "]d", diag.goto_next(), desc = "Next diagnostic" },
      { "[q", nqf.cprevious, desc = "Previous quickfix item" },
      { "]q", nqf.cnext, desc = "Next quickfix item" },

      {
        "[b",
        move.make_backward_repeatable_move(move_fn(vim.cmd.BufferLineMovePrev), move_fn(vim.cmd.BufferLineMoveNext)),
        desc = "Move buffer to previous",
      },
      {
        "]b",
        move.make_forward_repeatable_move(move_fn(vim.cmd.BufferLineMoveNext), move_fn(vim.cmd.BufferLineMovePrev)),
        desc = "Move buffer to next",
      },

      {
        "<S-h>",
        move.make_backward_repeatable_move(move_fn(vim.cmd.BufferLineCyclePrev), move_fn(vim.cmd.BufferLineCycleNext)),
        desc = "Prev buffer",
      },
      {
        "<S-l>",
        move.make_forward_repeatable_move(move_fn(vim.cmd.BufferLineCycleNext), move_fn(vim.cmd.BufferLineCyclePrev)),
        desc = "Next buffer",
      },
      {
        "zH",
        move.make_backward_repeatable_move(move_fn [[execute "normal! zH"]], move_fn [[execute "normal! zL"]]),
        desc = "Move window left",
      },
      {
        "zL",
        move.make_forward_repeatable_move(move_fn [[execute "normal! zL"]], move_fn [[execute "normal! zH"]]),
        desc = "Move window right",
      },
    }
  end,
}
