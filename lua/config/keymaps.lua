local keymaps = require("core.keymaps")

keymaps.del({
  { "n", "<leader>wd" },
  { "n", "<leader>K" },
  { "n", { "<leader>fT", "<leader>ft", "<C-/>", "<C-_>" } },
  { "n", { "<C-Up>", "<C-Down>", "<C-Left>", "<C-Right>" } },
  { "t", "<C-l>" },
})

keymaps.set({
  { "i", "<C-p>", "<Nop>" },
  { "i", "<C-n>", "<Nop>" },
  { "c", "<C-d>", "<Nop>" },
  { { "n", "i" }, "<D-z>", "<Cmd>undo<CR>" },
  { { "n", "i" }, "<D-Z>", "<Cmd>redo<CR>" },

  { "n", "<leader>wc", "<C-W>c", { desc = "Close window" } },
})
