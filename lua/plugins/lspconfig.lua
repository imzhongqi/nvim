return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      float = {
        border = "rounded",
      },
    },
    inlay_hints = {
      enabled = true,
    },
  },
}
