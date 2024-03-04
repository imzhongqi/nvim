return {
  "jbyuki/one-small-step-for-vimkind",
  cond = os.getenv "DEBUG" == "1",
  event = "VeryLazy",
  keys = function()
    return {
      {
        "<leader>rr",
        function()
          require("osv").launch { port = 8086 }
        end,
        desc = "Launch the debug server",
      },
    }
  end,
}
