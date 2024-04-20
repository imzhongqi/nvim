return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      float = {
        update_in_insert = true,
        border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
      },
    },
    inlay_hints = {
      enabled = false,
    },
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            hint = { enable = true },
          },
        },
      },
    },
  },
  init = function()
    require("util.lsp").on_attach(function(client, buffer)
      if client.supports_method "textDocument/inlayHint" then
        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
      end
    end)

    vim.list_extend(require("lazyvim.plugins.lsp.keymaps").get(), {
      { "<leader>cl", false },
      { "<leader>cli", "<cmd>LspInfo<cr>", desc = "Lsp Info" },

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
