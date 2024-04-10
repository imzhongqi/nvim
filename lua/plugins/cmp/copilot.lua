return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  {
    -- "zbirenbaum/copilot-cmp",
    "imzhongqi/copilot-cmp",
    dependencies = "copilot.lua",
    keys = {
      { "<leader>ac", "<cmd>Copilot toggle<CR>", mode = "n", desc = "Toggle Copilot" },
    },
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require "copilot_cmp"
      copilot_cmp.setup(opts)
      require("lazyvim.util").lsp.on_attach(function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter {}
        end
      end)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- "zbirenbaum/copilot-cmp",
      "imzhongqi/copilot-cmp",
    },
  },
}
