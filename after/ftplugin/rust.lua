require("util").keymaps_set({
  {
    "n",
    "<leader>ca",
    function()
      vim.cmd.RustLsp("codeAction")
    end,
    {
      desc = "Code Action",
    },
  },
  {
    "n",
    "<localleader>dc",
    function()
      vim.cmd.RustLsp("debuggables")
    end,
    {
      desc = "Run Debug",
    },
  },
})
