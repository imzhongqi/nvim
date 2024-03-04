return {
  "mfussenegger/nvim-dap-python",
  ft = { "python" },
  config = function()
    require("dap-python").setup(vim.fn.system "which python3")
  end,
}
