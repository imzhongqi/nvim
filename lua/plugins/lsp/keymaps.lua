return {
  "neovim/nvim-lspconfig",
  init = function()
    vim.list_extend(require("lazyvim.plugins.lsp.keymaps").get(), {
      { "<c-k>", false, mode = "i" },

      {
        "gd",
        function()
          require("fzf-lua").lsp_definitions {
            jump_to_single_result = true,
          }
        end,
        desc = "Goto Definition",
        has = "definition",
      },
      { "<c-p>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

      {
        "gr",
        function()
          require("fzf-lua").lsp_references {
            jump_to_single_result = true,
            ignore_current_line = true,
          }
        end,
        desc = "Goto References",
      },

      {
        "gD",
        vim.lsp.buf.declaration,
        desc = "Goto Declaration",
      },

      {
        "gI",
        function() require("fzf-lua").lsp_implementations {} end,
        desc = "Goto Implementation",
      },

      {
        "gy",
        function()
          require("fzf-lua").lsp_typedefs {
            jump_to_single_result = true,
            ignore_current_line = true,
          }
        end,
        desc = "Goto T[y]pe Definition",
      },
    })
  end,
}
