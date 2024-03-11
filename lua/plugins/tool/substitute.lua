return {
  { "folke/flash.nvim", enabled = false },

  {
    "gbprod/substitute.nvim",
    event = "LazyFile",
    keys = {
      { "s", function() require("substitute").operator() end },
      { "ss", function() require("substitute").line() end },
      { "S", function() require("substitute").eol() end },
      { "s", function() require("substitute").visual() end },
    },
    opts = {
      highlight_substituted_text = {
        enabled = true,
      },
    },
  },
}
