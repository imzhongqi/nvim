local bufnr = vim.api.nvim_get_current_buf()

require("core.keymaps").set({
  {
    "n",
    "<leader>ca",
    function()
      vim.cmd.RustLsp("codeAction")
    end,
    {
      buffer = bufnr,
      desc = "Code Action",
    },
  },
  {
    "n",
    "<localleader>cd",
    function()
      vim.cmd.RustLsp("debuggables")
    end,
    {
      buffer = bufnr,
      desc = "Run Debug",
    },
  },
})
