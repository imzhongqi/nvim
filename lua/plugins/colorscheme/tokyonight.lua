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

    on_highlights = function(hi)
      hi.Title.blend = 30
      -- hi.FloatBorder.blend = 80
      hi.FloatBorder.bg = "none"
      hi.FloatTitle.blend = 30
      hi.DiagnosticInfo.bg = "none"
      hi.DiagnosticUnderlineWarn.sp = "#a5814d"
      hi.LspInlayHint.bg = "none"
    end,
  },
}
