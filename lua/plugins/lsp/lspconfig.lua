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
      enabled = true,
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
