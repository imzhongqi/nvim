return {
  { "echasnovski/mini.pairs", enabled = false },

  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {

      tabout = { -- *ultimate-autopair-map-tabout-config*
        enable = true,
        map = "<A-tab>", --string or table
        cmap = "<A-tab>", --string or table
        conf = {},
        --contains extension config
        multi = false,
        --use multiple configs (|ultimate-autopair-map-multi-config|)
        hopout = false,
        -- (|) > tabout > ()|
        do_nothing_if_fail = true,
        --add a module so that if close fails
        --then a `\t` will not be inserted
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    enabled = false,
    event = "InsertEnter",
    opts = {
      ---@usage  modifies the function or method delimiter by filetypes
      map_char = {
        all = "(",
        tex = "{",
      },
      ---@usage check bracket in same line
      enable_check_bracket_line = false,
      ---@usage check treesitter
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
      enable_moveright = true,
      ---@usage disable when recording or executing a macro
      disable_in_macro = false,
      ---@usage add bracket pairs after quote
      enable_afterquote = true,
      ---@usage map the <BS> key
      map_bs = true,
      ---@usage map <c-w> to delete a pair if possible
      map_c_w = false,
      ---@usage disable when insert after visual block mode
      disable_in_visualblock = false,
      ---@usage  change default fast_wrap
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },
  },
}
