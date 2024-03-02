local icons = require("icons")

return {
  "LazyVim/LazyVim",
  version = false,

  opts = {
    -- colorscheme = "tokyonight",
    colorscheme = "nightfox",

    defaults = {
      autocmds = true,
      keymaps = false,
    },

    news = {
      -- When enabled, NEWS.md will be shown when changed.
      -- This only contains big new features and breaking changes.
      lazyvim = true,
      -- Same but for Neovim's news.txt
      neovim = true,
    },

    icons = {
      misc = {
        dots = _Icons.misc.dots,
      },
      dap = {
        Stopped = { _Icons.dap.Stopped, "DapSignStopped", "DapStoppedLine" },
        Breakpoint = { _Icons.dap.Breakpoint, "DiagnosticError" },
        BreakpointCondition = { _Icons.dap.BreakpointCondition, "DiagnosticError" },
        BreakpointRejected = { _Icons.dap.BreakpointRejected, "DiagnosticError" },
        LogPoint = _Icons.dap.LogPoint,
      },
      diagnostics = {
        Error = _Icons.diagnostics.Error_,
        Warn = _Icons.diagnostics.Warn_,
        Hint = _Icons.diagnostics.Hint_,
        Info = _Icons.diagnostics.Info_,
      },
      git = {
        added = _Icons.git.added_,
        modified = _Icons.git.modified_,
        removed = _Icons.git.deleted_,
      },
      kinds = icons.kinds,
    },
  },
}
