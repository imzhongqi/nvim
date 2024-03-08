local Util = require "util"

local icons = {
  ui = {
    FolderClosed = "󰉋",
    FolderOpen = "󰝰",
    FolderEmpty = "󰉖",
    FileDefault = "󰈙",
    Expanded = "",
    Collapsed = "",
  },

  telescope = {
    prompt_prefix = "  ",
    selection_caret = " ",
  },

  fzflua = {
    suffix = "❯ ",
    pointer = "  ",
    scrollbar = "▊",
    marker = " ",

    git = {
      added = "+",
      modified = "M",
      deleted = "-",
    },
  },

  neotest = {
    passed = "󰄴",
    failed = "",
    running = "",
    skipped = "",
    unknown = "",
    watching = "",
  },

  misc = {
    dots = "󰇘",
    ok = "✔",
    err = "✘",
  },

  dap = {
    Stopped = "",
    Breakpoint = "",
    BreakpointCondition = "",
    BreakpointRejected = "",
    LogPoint = "",
  },

  diagnostics = {
    Error = "",
    Warn = "",
    Hint = "󰌵",
    Info = "",

    Error_ = " ",
    Warn_ = " ",
    Hint_ = "󰌵 ",
    Info_ = " ",
  },

  git = {
    added = "",
    modified = "",
    deleted = "",
    renamed = "󰑕",
    untracked = "",
    ignored = "",
    unstaged = "",
    staged = "",
    conflict = "",

    added_ = " ",
    modified_ = " ",
    deleted_ = " ",
  },

  kinds = {
    Codeium = "󰘦",
    Control = "",
    Collapsed = "",
    Copilot = "",
    TabNine = "󰏚",

    Array = "",
    Boolean = "",
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰜢",
    File = "󰈙",
    Folder = "󰉋",
    Function = "",
    Interface = "",
    Key = "",
    Keyword = "",
    Method = "",
    Module = "",
    Namespace = "",
    Null = "󰟢",
    Number = "",
    Object = "",
    Operator = "",
    Package = "",
    Property = "󰜢",
    Reference = "",
    Snippet = "",
    String = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
  },

  kinds_with_space = {
    Codeium = "󰘦 ",
    Control = " ",
    Collapsed = " ",
    Copilot = " ",
    TabNine = "󰏚 ",

    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = "󰜢 ",
    File = "󰈙 ",
    Folder = "󰉋 ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = "󰟢 ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = "󰜢 ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
}

return icons
