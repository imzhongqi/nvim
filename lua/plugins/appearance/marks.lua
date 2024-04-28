return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  keys = {
    { "dm", "<Cmd>lua require'marks'.delete()<CR>", "Delete mark" },
    { "dm<Space>", "<Cmd>lua require'marks'.delete_buf()<CR>", "Delete buffer mark" },
  },
  opts = {
    default_mappings = false,
    sign_priority = { lower = 10, upper = 15, builtin = 5, bookmark = 20 },
    excluded_buftypes = { "nofile" },
    builtin_marks = {},
  },
}
