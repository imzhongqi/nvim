local Util = require("lazyvim.util")
local map = vim.keymap.set
local keymaps_del = require("util").keymaps_del
local keymaps_set = require("util").keymaps_set

keymaps_set({
  { "i", "<C-p>", "<Nop>" },
  { "i", "<C-n>", "<Nop>" },
  { "c", "<C-d>", "<Nop>" },
  { { "n", "i" }, "<D-z>", "<Cmd>undo<CR>" },
  { { "n", "i" }, "<D-Z>", "<Cmd>redo<CR>" },

  { "n", "<leader>wc", "<C-W>c", { desc = "Close window" } },

  -- better up/down
  { { "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },
  { { "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },
  { { "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
  { { "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },

  -- Move to window using the <ctrl> hjkl keys
  -- { "n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true } },
  -- { "n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true } },
  -- { "n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true } },
  -- { "n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true } },

  -- Move Lines
  { "n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" } },
  { "n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" } },
  { "i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" } },
  { "i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" } },
  { "v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" } },
  { "v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" } },

  -- buffers
  { "n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" } },
  { "n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" } },
  { "n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" } },
  { "n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" } },
  { "n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" } },
  { "n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" } },
  -- Clear search, diff update and redraw
  -- taken from runtime/lua/_editor.lua
  {
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" },
  },

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  { "n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" } },
  { "x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" } },
  { "o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" } },
  { "n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" } },
  { "x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" } },
  { "o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" } },

  { "n", "<leader>mlr", "<cmd>LspRestart<CR>", { desc = "Lsp Restart" } },
  { "n", "<leader>mls", "<cmd>LspStart<CR>", { desc = "Lsp Start" } },
  { "n", "<leader>mlx", "<cmd>LspStop<CR>", { desc = "Lsp Stop" } },
  { "n", "<leader>mll", "<cmd>LspLog<CR>", { desc = "Lsp Log" } },

  { "n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" } },

  -- Add undo break-points
  { "i", ",", ",<c-g>u" },
  { "i", ".", ".<c-g>u" },
  { "i", ";", ";<c-g>u" },

  -- better indenting
  { "v", "<", "<gv" },
  { "v", ">", ">gv" },

  -- save file
  { { "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" } },

  { "n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" } },

  -- stylua: ignore start
{"n", "<leader>uf", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" }},
{"n", "<leader>uF", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" }},
{"n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" }},
{"n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" }},
{"n", "<leader>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" }},
{"n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" }},
{"n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" }},
{"n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" }},
  -- stylua: ignore end

  {
    "n",
    "<leader>cd",
    function()
      local bufnr = vim.diagnostic.open_float()
      vim.api.nvim_set_option_value("winhighlight", "NormalFloat:Normal", { buf = bufnr })
    end,
    { desc = "Line Diagnostics" },
  },
})

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map("n", "<leader>uh", function()
    Util.toggle.inlay_hints()
  end, { desc = "Toggle Inlay Hints" })
end
