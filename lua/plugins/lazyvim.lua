local icons = require "config.icons"

vim.g.lazyvim_picker = "fzf"

-- Enable LazyVim auto format
vim.g.autoformat = true

vim.g.root_spec = { "lsp", { ".git", "lua", "README.md", "Cargo.toml", "Makefile", "src" }, "cwd" }

return {
  "LazyVim/LazyVim",
  lazy = false,
  version = false,

  opts = {
    -- colorscheme = "tokyonight",
    colorscheme = "nightfox",

    defaults = {
      autocmds = true,
      keymaps = false,
    },

    news = {
      lazyvim = false,
      neovim = false,
    },

    icons = {
      misc = {
        dots = _Icons.misc.dots,
      },
      dap = {
        Stopped = { _Icons.dap.Stopped, "DiagnosticWarn", "DapStoppedLine" },
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
      kinds = icons.kinds_with_space,
    },
  },
  init = function()
    if vim.g.vscode then
      vim.lsp.inlay_hint.enable(false)
    end
  end,
}
