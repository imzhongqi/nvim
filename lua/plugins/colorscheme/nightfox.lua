return {
  "EdenEast/nightfox.nvim",
  lazy = true,
  -- priority = 1000,
  opts = function()
    return {
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath "cache" .. "/nightfox",
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
        inverse = { -- Inverse highlight for different types
          match_paren = true,
          visual = false,
          search = false,
        },
        modules = {
          native_lsp = {
            background = false,
          },
        },
      },
      groups = {
        all = {
          ["NormalFloat"] = { link = "Normal" },
          ["FloatBorder"] = { fg = "#39506d" },

          ["@variable"] = { fg = "palette.white.dim" },
          ["@variable.member"] = { fg = "palette.orange" },
          ["@property"] = { fg = "palette.orange" },
          ["@parameter"] = { fg = "palette.cyan.dim" },
          ["@module"] = { fg = "palette.blue" },
          ["@type.builtin"] = { fg = "palette.yellow" },

          ["NoicePopupBorder"] = { link = "FloatBorder" },
          ["NoicePopupmenuBorder"] = { link = "FloatBorder" },
          ["NoiceCmdlinePopupBorder"] = { link = "FloatBorder" },
          ["FzfLuaBorder"] = { link = "FloatBorder" },

          ["TreesitterContext"] = { bg = "#222f40" },
          ["ScrollView"] = { bg = "#39506d" },
          ["ScrollViewHover"] = { bg = "#3e4957" },
          ["WinSeparator"] = { fg = "#141b25" },
        },
      },
    }
  end,
}
