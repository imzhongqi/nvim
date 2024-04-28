require("util").keymaps_set {
  {
    "<leader>ca",
    function() vim.cmd.RustLsp "codeAction" end,
    desc = "Code Action",
  },
  {
    "<localleader>dc",
    function() vim.cmd.RustLsp "debuggables" end,
    desc = "Run Debug",
  },
  {
    "<leader>cls",
    "<Cmd>RustAnalyzer start<CR>",
    desc = "Lsp Restart",
  },
  {
    "<leader>clr",
    "<Cmd>RustAnalyzer restart<CR>",
    desc = "Lsp Restart",
  },
  {
    "<leader>clx",
    "<Cmd>RustAnalyzer stop<CR>",
    desc = "Lsp Stop",
  },
}
