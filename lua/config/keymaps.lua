local keymaps_del = require("util").keymaps_del
local keymaps_set = require("util").keymaps_set

keymaps_del({
  { "n", "<leader>wd" },
  { "n", "<leader>K" },
  { "n", { "<leader>fT", "<leader>ft", "<C-/>", "<C-_>" } },
  { "n", { "<C-Up>", "<C-Down>", "<C-Left>", "<C-Right>" } },
  { "t", "<C-l>" },
})

keymaps_set({
  { "i", "<C-p>", "<Nop>" },
  { "i", "<C-n>", "<Nop>" },
  { "c", "<C-d>", "<Nop>" },
  { { "n", "i" }, "<D-z>", "<Cmd>undo<CR>" },
  { { "n", "i" }, "<D-Z>", "<Cmd>redo<CR>" },

  { "n", "<leader>wc", "<C-W>c", { desc = "Close window" } },

  { "n", "<leader>mlr", "<cmd>LspRestart<CR>", { desc = "Lsp Restart" } },
  { "n", "<leader>mls", "<cmd>LspStart<CR>", { desc = "Lsp Start" } },
  { "n", "<leader>mlx", "<cmd>LspStop<CR>", { desc = "Lsp Stop" } },
  { "n", "<leader>mll", "<cmd>LspLog<CR>", { desc = "Lsp Log" } },
})
