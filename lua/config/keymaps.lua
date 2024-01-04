-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymaps = require("core.keymaps")

keymaps.del({
  { "n", "<leader>K" },
  { "n", { "<leader>fT", "<leader>ft", "<C-/>", "<C-_>" } },
  { "n", { "<C-Up>", "<C-Down>", "<C-Left>", "<C-Right>" } },
  { "t", { "<C-l>" } },
})
