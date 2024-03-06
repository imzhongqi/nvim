return {
  "ghostbuster91/nvim-next",
  event = "VeryLazy",
  keys = function()
    local integrations = require "nvim-next.integrations"
    local diag = integrations.diagnostic()
    local nqf = integrations.quickfix()
    return {
      { "[d", diag.goto_prev(), desc = "Previous diagnostic" },
      { "]d", diag.goto_next(), desc = "Next diagnostic" },
      { "[q", nqf.cprevious, desc = "Previous quickfix item" },
      { "]q", nqf.cnext, desc = "Next quickfix item" },
    }
  end,
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
  end,
}
