return {
  "EdenEast/nightfox.nvim",
  opts = function()
    local Color = require("nightfox.lib.color")
    local palette = require("nightfox.palette").load("nightfox")

    return {
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false, -- Disable setting background
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false, -- Non focused panes set to alternative background
        module_default = true,
        styles = { -- Style to be applied to different syntax groups
          comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
          conditionals = "NONE",
          constants = "NONE",
          functions = "NONE",
          keywords = "NONE",
          numbers = "NONE",
          operators = "NONE",
          strings = "NONE",
          types = "NONE",
          variables = "NONE",
        },
        -- inverse = { -- Inverse highlight for different types
        --   match_paren = false,
        --   visual = false,
        --   search = false,
        -- },
        modules = {
          native_lsp = {
            background = false,
          },
        },
      },
      groups = {
        all = {
          ["@property"] = { fg = "palette.green.bright" },
          ["@module"] = { fg = "palette.blue" },
        },
      },
    }
  end,
}
