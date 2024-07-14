local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.runtimepath:prepend(vim.env.LAZY or lazypath)

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },

  install = {
    missing = true,
    colorscheme = {
      "default",
    },
  },

  diff = {
    cmd = "diffview.nvim",
  },

  ui = {
    border = "solid",
    size = {
      width = 1,
      height = 0.9,
    },
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
        "nvim",
        "rplugin",
        "spellfile",
      },
    },
  },

  readme = {
    enabled = true,
  },

  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = true,
    -- Track each new require in the Lazy profiling tab
    require = true,
  },
})
