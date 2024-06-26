return {
  { "folke/lazy.nvim", tag = "stable" },
  { "nvim-lua/plenary.nvim" },

  { "LazyVim/LazyVim", import = "lazyvim.plugins" },

  { import = "plugins.colorscheme" },
  { import = "plugins.appearance" },
  { import = "plugins.treesitter" },
  { import = "plugins.lang" },
  { import = "plugins.lang.filetype" },
  { import = "plugins.lsp" },
  { import = "plugins.cmp" },
  { import = "plugins.dap" },
  { import = "plugins.tool" },
}
