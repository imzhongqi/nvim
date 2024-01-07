return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      table.insert(keys, {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufRead" },
    dependencies = "kevinhwang91/promise-async",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
  },
}
