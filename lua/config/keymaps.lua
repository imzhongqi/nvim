local Util = require "lazyvim.util"
local keymaps_set = require("util").keymaps_set
local get_selected_text = require("util").get_selected_text

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3

keymaps_set {
  { "<C-p>", "", mode = "i" },
  { "<C-n>", "", mode = "i" },
  { "<C-d>", "", mode = "c" },
  { "<cmd>undo<CR>", "<D-z>", mode = { "n", "i" } },
  { "<cmd>redo<CR>", "<D-Z>", mode = { "n", "i" } },

  -- Clear search with <esc>
  { "<esc>", "<cmd>noh<cr><esc>", mode = { "i", "n" }, desc = "Escape and clear hlsearch" },

  { "[o", [[<cmd>execute "normal! O"<CR>]], desc = "Put a blank line in the previous line" },
  { "]o", [[<cmd>execute "normal! o"<CR>]], desc = "Put a blank line in the next line" },

  { "<leader>uc", function() Util.toggle("conceallevel", false, { 0, conceallevel }) end, desc = "Toggle Conceal" },

  -- better up/down
  { "j", "v:count == 0 ? 'gj' : 'j'", mode = { "n", "x" }, expr = true },
  { "<Down>", "v:count == 0 ? 'gj' : 'j'", mode = { "n", "x" }, expr = true },
  { "k", "v:count == 0 ? 'gk' : 'k'", mode = { "n", "x" }, expr = true },
  { "<Up>", "v:count == 0 ? 'gk' : 'k'", mode = { "n", "x" }, expr = true },
  {
    "<C-w>c",
    function()
      require("mini.bufremove").delete()
      local winc = #vim
        .iter(vim.api.nvim_list_wins())
        :map(vim.api.nvim_win_get_config)
        :filter(function(wc) return wc.split end)
        :totable()
      if (not vim.g.neotree_opened and winc > 1) or (vim.g.neotree_opened and winc > 2) then
        pcall(vim.api.nvim_win_close, 0, true)
      end
    end,
    desc = "Remove buffer and close window",
  },
  -- { "j", [[v:count ? (v:count >= 3 ? "m'" . v:count : '') . 'j' : 'gj']], mode = "n", expr = true },
  -- { "k", [[v:count ? (v:count >= 3 ? "m'" . v:count : '') . 'k' : 'gk']], mode = "n", expr = true },

  -- Move to window using the <ctrl> hjkl keys
  { "<C-h>", "<cmd>wincmd h<CR>", desc = "Go to left window" },
  { "<C-j>", "<cmd>wincmd j<CR>", desc = "Go to lower window" },
  { "<C-k>", "<cmd>wincmd k<CR>", desc = "Go to upper window" },
  { "<C-l>", "<cmd>wincmd l<CR>", desc = "Go to right window" },

  -- Move Lines
  { "<A-j>", "<cmd>m .+1<cr>==", desc = "Move down" },
  { "<A-k>", "<cmd>m .-2<cr>==", desc = "Move up" },
  { "<A-j>", "<esc><cmd>m .+1<cr>==gi", desc = "Move down", mode = "i" },
  { "<A-k>", "<esc><cmd>m .-2<cr>==gi", desc = "Move up", mode = "i" },
  { "<A-j>", ":m '>+1<cr>gv=gv", desc = "Move down", mode = "v" },
  { "<A-k>", ":m '<-2<cr>gv=gv", desc = "Move up", mode = "v" },

  -- buffers
  -- { "<S-h>", "<cmd>bprevious<cr>", desc = "Prev buffer" },
  -- { "<S-l>", "<cmd>bnext<cr>", desc = "Next buffer" },
  -- { "[b", "<cmd>bprevious<cr>", desc = "Prev buffer" },
  -- { "]b", "<cmd>bnext<cr>", desc = "Next buffer" },
  { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
  { "<leader>`", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },

  -- Clear search, diff update and redraw
  -- taken from runtime/lua/_editor.lua
  {
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    desc = "Redraw / clear hlsearch / diff update",
  },

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  { "n", "'Nn'[v:searchforward].'zv'", expr = true, desc = "Next search result" },
  { "n", "'Nn'[v:searchforward]", mode = "x", expr = true, desc = "Next search result" },
  { "n", "'Nn'[v:searchforward]", mode = "o", expr = true, desc = "Next search result" },
  { "N", "'nN'[v:searchforward].'zv'", expr = true, desc = "Prev search result" },
  { "N", "'nN'[v:searchforward]", mode = "x", expr = true, desc = "Prev search result" },
  { "N", "'nN'[v:searchforward]", mode = "o", expr = true, desc = "Prev search result" },

  { "<leader>mlr", "<cmd>LspRestart<CR>", desc = "Lsp Restart" },
  { "<leader>mls", "<cmd>LspStart<CR>", desc = "Lsp Start" },
  { "<leader>mlx", "<cmd>LspStop<CR>", desc = "Lsp Stop" },
  { "<leader>mll", "<cmd>LspLog<CR>", desc = "Lsp Log" },

  { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },

  -- Add undo break-points
  { ",", ",<c-g>u", mode = "i" },
  { ".", ".<c-g>u", mode = "i" },
  { ";", ";<c-g>u", mode = "i" },

  -- better indenting
  { "<", "<gv", mode = "v" },
  { ">", ">gv", mode = "v" },

  -- save file
  { "<C-s>", "<cmd>w<cr><esc>", mode = { "i", "x", "n", "s" }, desc = "Save file" },
  { "<C-q><C-q>", "<cmd>qa<cr>", mode = "n", desc = "Quit all" },

  { "<leader><tab>l", "<cmd>tablast<cr>", desc = "Last Tab" },
  { "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "First Tab" },

  {
    "<leader><tab><tab>",
    [[<cmd>if expand("%") != "" | tabnew % | else | tabnew | endif <CR>]],
    desc = "New Tab",
  },
  { "<leader><tab>]", "<cmd>tabnext<cr>", desc = "Next Tab" },
  { "<leader><tab>d", "<cmd>tabclose<cr>", desc = "Close Tab" },
  { "<leader><tab>[", "<cmd>tabprevious<cr>", desc = "Previous Tab" },

  -- stylua: ignore start
  {"<leader>uf", function() Util.format.toggle() end,  desc = "Toggle auto format (global)" },
  {"<leader>uF", function() Util.format.toggle(true) end,  desc = "Toggle auto format (buffer)" },
  {"<leader>us", function() Util.toggle("spell") end,  desc = "Toggle Spelling" },
  {"<leader>uw", function() Util.toggle("wrap") end,  desc = "Toggle Word Wrap" },
  {"<leader>uL", function() Util.toggle("relativenumber") end,  desc = "Toggle Relative Line Numbers" },
  {"<leader>ul", function() Util.toggle.number() end,  desc = "Toggle Line Numbers" },
  {"<leader>ud", function() Util.toggle.diagnostics() end,  desc = "Toggle Diagnostics" },
  {"<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end,  desc = "Toggle Treesitter Highlight" },
  { "<leader>uh", function() Util.toggle.inlay_hints() end, desc = "Toggle Inlay Hints", cond = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint },
  -- stylua: ignore end

  { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },

  {
    "<leader>mt",
    function()
      local mode = vim.api.nvim_get_mode().mode
      local text
      if mode == "v" or mode == "V" then
        text = get_selected_text()
      else
        -- text = vim.api.nvim_get_current_line()
        text = vim.fn.expand "<cword>"
      end

      local handle
      handle = vim.uv.spawn("osascript", {
        args = {
          "-l",
          "JavaScript",
          "-e",
          string.format(
            'Application("com.hezongyidev.Bob").request(JSON.stringify(%s))',
            vim.json.encode {
              path = "translate",
              body = {
                action = "translateText",
                windowLocation = "last",
                text = text,
              },
            }
          ),
        },
      }, function(exit_code)
        if exit_code ~= 0 then
          vim.notify(string.format("failed to run script, exit code: %d", exit_code), vim.log.levels.ERROR)
        end
        if handle and not handle:is_closing() then
          handle:close()
        end
      end)
    end,
    mode = { "v", "n" },
    desc = "Call Bob translator",
    cond = vim.fn.executable "osascript" == 1,
  },
}
