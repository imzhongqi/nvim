return {
  "luukvbaal/statuscol.nvim",
  event = "BufReadPost",
  branch = "0.10",
  opts = function()
    local builtin = require("statuscol.builtin")

    local nu = function(args)
      return args.nu
    end

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
        {
          sign = {
            name = { "Dap*" },
            auto = true,
          },
          condition = { nu },
          click = "v:lua.ScSa",
        },
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
          condition = { true, builtin.not_empty },
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
            " ",
          },
          condition = { nu, builtin.not_empty },
          click = "v:lua.ScFa",
        },
      },
    }
  end,
}
