return {
  "jbyuki/one-small-step-for-vimkind",
  enabled = false,
  keys = function()
    return {
      {
        "<leader>rr",
        function()
          require("osv").launch({ port = 8086 })
        end,
        desc = "Launch the debug server",
      },
    }
  end,
}
