return {
  "folke/tokyonight.nvim",
  opts = {
    style = "moon",

    styles = {
      comments = { italic = true },
      keywords = { italic = false, bold = true },
      functions = {},
      variables = {},
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },

    on_highlights = function(
      hi --[[ , color ]]
    )
      hi.Title.blend = 30
      hi.FloatBorder.blend = 30
      hi.FloatTitle.blend = 30
      hi.DiagnosticInfo.blend = 30
    end,
  },
}
