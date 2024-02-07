return {
  { "folke/lazy.nvim", tag = "stable" },
  { "rcarriga/nvim-notify", enabled = false },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local Config = require("lazyvim.config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3] })
      end
    end,
  },
}
