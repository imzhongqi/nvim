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
    suffix = " ",
    pointer = " ",
    scrollbar = "▊",
    marker = "",
  },

  misc = {
    dots = "󰇘",
    ok = "✔",
    err = "✘",
  },

  dap = {
    Stopped = "",
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
}

return setmetatable(icons, {
  __index = function(t, k)
    if t[k] == nil then
      return nil
    end

    return setmetatable(t[k], {
      __index = function(_t, key)
        if Util.has_suffix(key, "_") then
          local icon = _t[string.sub(key, 0, string.len(key) - 1)]
          if icon ~= nil then
            return icon .. " "
          end
        end
      end,
    })
  end,
})
