require("lazy").setup {
  spec = {
    { "folke/lazy.nvim", tag = "stable" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
    { import = "plugins.colorscheme" },
    { import = "plugins.appearance" },
    { import = "plugins.treesitter" },
    { import = "plugins.lang" },
    { import = "plugins.lang.filetype" },
    { import = "plugins.lsp" },
    { import = "plugins.cmp" },
    { import = "plugins.dap" },
    { import = "plugins.tool" },
  },

  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },

  install = {
    missing = false,
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

  concurrency = 8,

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
        "nvim",
        "rplugin",
        "spellfile",
      },
    },
  },

  readme = {
    enabled = false,
  },

  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = true,
    -- Track each new require in the Lazy profiling tab
    require = true,
  },
}
