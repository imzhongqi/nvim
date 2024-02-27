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
      local wk = require("which-key")

      wk.register({
        ["]h"] = { gs.next_hunk, "Next Hunk" },
        ["[h"] = { gs.preview_hunk, "Prev Hunk" },
        ["<leader>ghS"] = { gs.stage_buffer, "Stage Buffer" },
        ["<leader>ghu"] = { gs.undo_stage_hunk, "Undo Stage Hunk" },
        ["<leader>ghR"] = { gs.reset_buffer, "Reset Buffer" },
        ["<leader>ghp"] = { gs.preview_hunk, "Preview Buffer" },
        ["<leader>ghb"] = {
          function()
            gs.blame_line({ full = true })
          end,
          "Blame Line",
        },
        ["<leader>ghd"] = { gs.diffthis, "Diff This" },
        ["<leader>ghD"] = {
          function()
            gs.diffthis("~")
          end,
          "Diff This ~",
        },
      }, { mode = "n" })

      wk.register({
        ["<leader>ghs"] = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
        ["<leader>ghr"] = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
      }, { mode = { "n", "v" } })

      wk.register({
        ["ih"] = { "<Cmd><C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk" },
      }, { mode = { "o", "x" } })
    end,
  },
}
