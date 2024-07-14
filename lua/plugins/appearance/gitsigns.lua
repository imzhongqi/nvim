return {
  "lewis6991/gitsigns.nvim",
  dependencies = "folke/which-key.nvim",
  event = "LazyFile",
  opts = {
    attach_to_untracked = true,
    signs = {
      add = { text = "▍" },
      change = { text = "▍" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▍" },
      untracked = { text = "▍" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      local wk = require "which-key"
      local next_integrations = require "nvim-next.integrations"
      local ngs = next_integrations.gitsigns(gs)

      wk.add({
        {
          "]h",
          function()
            if vim.wo.diff then
              return "[h"
            end
            vim.schedule(function() ngs.prev_hunk() end)
            return "<Ignore>"
          end,
          desc = "Next Hunk",
        },
        {
          "[h",
          function()
            if vim.wo.diff then
              return "[h"
            end
            vim.schedule(function() ngs.prev_hunk() end)
            return "<Ignore>"
          end,
          desc = "Prev Hunk",
        },
        { "<leader>ghS", gs.stage_buffer, desc = "Stage Buffer" },
        { "<leader>ghu", gs.undo_stage_hunk, desc = "Undo Stage Hunk" },
        { "<leader>ghR", gs.reset_buffer, desc = "Reset Buffer" },
        { "<leader>ghp", gs.preview_hunk, desc = "Preview Buffer" },
        { "<leader>ghb", function() gs.blame_line { full = true } end, desc = "Blame Line" },
        { "<leader>ghd", gs.diffthis, desc = "Diff This" },
        { "<leader>ghD", function() gs.diffthis "~" end, desc = "Diff This ~" },
      }, { mode = "n" })

      wk.add({
        { "<leader>ghs", "<Cmd>Gitsigns stage_hunk<CR>", desc = "Stage Hunk" },
        { "<leader>ghr", "<Cmd>Gitsigns reset_hunk<CR>", desc = "Reset Hunk" },
      }, { mode = { "n", "v" } })

      wk.add({
        { "ih", "<Cmd><C-U>Gitsigns select_hunk<CR>", desc = "GitSigns Select Hunk" },
      }, { mode = { "o", "x" } })
    end,
  },
}
