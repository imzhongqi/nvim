require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins.colorscheme" },
    { import = "plugins" },
    { import = "plugins.appearance" },
    { import = "plugins.lang" },
    { import = "plugins.filetype" },
    { import = "plugins.tools" },
  },

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
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
        -- "man",
        "zipPlugin",
        "osc52", -- Wezterm doesn't support osc52 yet
        "shada",
        "nvim",
        "rplugin",
        "spellfile",
      },
    },
  },
})
