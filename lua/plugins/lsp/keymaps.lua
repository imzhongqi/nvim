return {
  "neovim/nvim-lspconfig",
  init = function()
    vim.list_extend(require("lazyvim.plugins.lsp.keymaps").get(), {
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
      {
        "gr",
        function()
          require("fzf-lua").lsp_references {
            jump_to_single_result = true,
            ignore_current_line = true,
          }
        end,
        desc = "References",
      },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      {
        "gI",
        function()
          require("fzf-lua").lsp_implementations {
            jump_to_single_result = true,
            ignore_current_line = true,
          }
        end,
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
