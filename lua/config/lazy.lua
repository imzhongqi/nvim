require("lazy").setup {
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins.colorscheme" },
    { import = "plugins" },
    { import = "plugins.appearance" },
    { import = "plugins.lsp" },
    { import = "plugins.treesitter" },
    { import = "plugins.lang" },
    { import = "plugins.dap" },
    { import = "plugins.filetype" },
    { import = "plugins.tool" },
  },

  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },

  install = {
    missing = true,
    colorscheme = {
      "tokyonight",
    },
  },

  diff = {
    cmd = "diffview.nvim",
  },

  ui = {
    border = "solid",
    size = { width = 1, height = 0.9 },
  },

  checker = { enabled = false }, -- automatically check for plugin updates

  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },

  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "man",
        "zipPlugin",
        "osc52", -- Wezterm doesn't support osc52 yet
        "shada",
        -- "nvim",
        "rplugin",
        "spellfile",
      },
    },
  },
}
