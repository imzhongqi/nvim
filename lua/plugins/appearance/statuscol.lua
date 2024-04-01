return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  branch = "0.10",
  opts = function()
    local builtin = require "statuscol.builtin"

    local nu = function(args) return args.nu or args.rnu end

    return {
      relculright = true,
      bt_ignore = { "terminal" },
      ft_ignore = {
        "neo-tree",
        "dbui",
        "undotree",
      },
      setopt = true,
      segments = {
        -- {
        --   sign = {
        --     name = { "Dap*" },
        --     auto = true,
        --   },
        --   condition = { nu },
        --   click = "v:lua.ScSa",
        -- },

        {
          sign = {
            name = { ".*" },
            text = { ".*" },
            namespace = { ".*" },
          },
          condition = { nu },
          click = "v:lua.ScSa",
        },
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, nu },
          click = "v:lua.ScLa",
        },
        {
          sign = {
            namespace = { "git" },
            colwidth = 1,
          },
          condition = { nu },
          click = "v:lua.ScSa",
        },
        {
          text = {
            function(args)
              args.fold.close = _Icons.ui.Collapsed
              args.fold.open = _Icons.ui.Expanded
              args.fold.sep = " "

              return builtin.foldfunc(args)
            end,
          },
          condition = { nu },
          click = "v:lua.ScFa",
        },
        { text = { " " }, condition = { nu } },
      },
    }
  end,
}
