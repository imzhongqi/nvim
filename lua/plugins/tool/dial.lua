return {
  "monaqa/dial.nvim",
  keys = function()
    local map = require "dial.map"
    return {
      { "<C-a>", map.inc_normal "common", desc = "Increment", mode = { "n" } },
      { "<C-x>", map.dec_normal "common", desc = "Decrement", mode = { "n" } },
      { "<C-a>", map.inc_normal "visual", desc = "Increment", mode = { "v" } },
      { "<C-x>", map.dec_normal "visual", desc = "Decrement", mode = { "v" } },

      { "<C-a>", map.inc_normal "markdown", desc = "Increment", mode = { "n" }, ft = "markdown" },
      { "<C-x>", map.dec_normal "markdown", desc = "Decrement", mode = { "n" }, ft = "markdown" },
    }
  end,
  opts = function()
    local augend = require "dial.augend"

    return {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
      },
      visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
      },
      markdown = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.new {
          elements = { "[x]", "[ ]" },
          word = false,
          cyclic = true,
        },
      },
      common = {
        augend.constant.new {
          elements = { "and", "or" },
          word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
          cyclic = true, -- "or" is incremented into "and".
        },
        augend.constant.new {
          elements = { "True", "False" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "yes", "no" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        },
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.semver.alias.semver,
      },
    }
  end,
  config = function(_, opts) require("dial.config").augends:register_group(opts) end,
}
