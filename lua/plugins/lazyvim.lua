local icons = require("icons")

return {
  "LazyVim/LazyVim",
  version = false,
  opts = {
    -- colorscheme = "tokyonight",
    colorscheme = "nightfox",

    icons = {
      misc = {
        dots = Icons.misc.dots,
      },
      dap = {
        Stopped = { Icons.dap.Stopped_, "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = { Icons.dap.Breakpoint_, "DiagnosticError" },
        BreakpointCondition = { Icons.dap.BreakpointCondition_, "DiagnosticError" },
        BreakpointRejected = { Icons.dap.BreakpointRejected_, "DiagnosticError" },
        LogPoint = Icons.dap.LogPoint_,
      },
      diagnostics = {
        Error = Icons.diagnostics.Error_,
        Warn = Icons.diagnostics.Warn_,
        Hint = Icons.diagnostics.Hint_,
        Info = Icons.diagnostics.Info_,
      },
      git = {
        added = Icons.git.added_,
        modified = Icons.git.modified_,
        removed = Icons.git.deleted_,
      },
      kinds = icons.kinds,
    },
  },
}
