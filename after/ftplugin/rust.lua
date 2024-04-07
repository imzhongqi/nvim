require("util").keymaps_set {
  {
    "<leader>ca",
    function() vim.cmd.RustLsp "codeAction" end,
    {
      desc = "Code Action",
    },
  },
  {
    "<localleader>dc",
    function() vim.cmd.RustLsp "debuggables" end,
    {
      desc = "Run Debug",
    },
  },
}
