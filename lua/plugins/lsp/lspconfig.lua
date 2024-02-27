return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      float = {
        -- border = "rounded",
        border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
        focusable = false,
        focus = false,
        win_options = {
          winhighlight = {
            Normal = "Normal",
          },
        },
      },
    },
    inlay_hints = {
      enabled = true,
    },
    capabilities = {
      semanticTokens = false,
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
}
