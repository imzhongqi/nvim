return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>", function() require("dial.map").inc_normal "common" end, desc = "Increment", mode = { "n" } },
    { "<C-x>", function() require("dial.map").dec_normal "common" end, desc = "Decrement", mode = { "n" } },
    { "<C-a>", function() require("dial.map").inc_normal "visual" end, desc = "Increment", mode = { "v" } },
    { "<C-x>", function() require("dial.map").dec_normal "visual" end, desc = "Decrement", mode = { "v" } },

    {
      "<C-a>",
      function() require("dial.map").inc_normal "markdown" end,
      desc = "Increment",
      mode = { "n" },
      ft = "markdown",
    },
    {
      "<C-x>",
      function() require("dial.map").dec_normal "markdown" end,
      desc = "Decrement",
      mode = { "n" },
      ft = "markdown",
    },
  },
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
    }
  end,
  config = function(_, opts) require("dial.config").augends:register_group(opts) end,
}
