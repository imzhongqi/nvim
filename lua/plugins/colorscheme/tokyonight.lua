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
      floats = "moon", -- style for floating windows
    },

    on_highlights = function(hi)
      hi.DiagnosticUnderlineWarn.sp = "#a5814d"
      hi.LspInlayHint.link = "Comment"
      hi.CmpItemMenu.link = "NormalFloat"
    end,
  },
}
