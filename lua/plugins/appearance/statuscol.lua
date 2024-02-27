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
      ft_ignore = { "neo-tree" },
      setopt = true,
      segments = {
        {
          sign = { name = { "Dap*" }, auto = true },
          click = "v:lua.ScSa",
        },
        {
          sign = {
            name = { ".*" },
            text = { ".*" },
            namespace = { ".*" },
          },
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
              args.fold.close = Icons.ui.Collapsed
              args.fold.open = Icons.ui.Expanded
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
