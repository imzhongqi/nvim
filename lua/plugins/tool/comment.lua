return {
  { "echasnovski/mini.comment", enabled = false },

  {
    "numToStr/Comment.nvim",
    event = "LazyFile",
    vscode = true,
    opts = {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    },
  },
}
