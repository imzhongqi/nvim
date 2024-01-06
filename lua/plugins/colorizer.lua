return {
  "NvChad/nvim-colorizer.lua",
  opts = {
    user_default_options = {
      mode = "foreground",
    },
  },
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers",
    "ColorizerToggle",
  },
  keys = {
    { "<leader>uct", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" },
  },
}
