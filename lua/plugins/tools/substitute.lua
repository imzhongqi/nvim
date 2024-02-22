return {
  { "folke/flash.nvim", enabled = false },

  {
    "gbprod/substitute.nvim",
    event = "LazyFile",
    opts = {
      highlight_substituted_text = {
        enabled = true,
      },
    },
    keys = function()
      vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
      vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
      vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
      vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
      return {}
    end,
  },
}
