vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable LazyVim auto format
vim.g.autoformat = true

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

require("core.options").set({
  -- swapfile = false,
  foldcolumn = "1",
  foldlevel = 99,
  foldlevelstart = 99,
  foldenable = true,

  autowrite = true, -- Enable auto write
  clipboard = "unnamedplus", -- Sync with system clipboard
  completeopt = "menu,menuone,noselect",
  conceallevel = 3, -- Hide * markup for bold and italic
  pumblend = 10,
  pumheight = 10,

  relativenumber = true,
  number = true,

  tabstop = 2,
  timeoutlen = 300,

  shiftround = true,
  shiftwidth = 2,
  smartcase = true, -- Don't ignore case with capitals
  smartindent = true, -- Insert indents automatically
  spelllang = { "en" },
  showmode = false, -- Dont show mode since we have a statusline
  sidescrolloff = 8, -- Columns of context
  signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
  shortmess = function(opt)
    opt:append({ W = true, I = true, c = true, C = true })
  end,

  undolevels = 10000,
  updatetime = 200, -- Save swap file and trigger CursorHold

  wildmode = "longest:full,full", -- Command-line completion mode
  winminwidth = 5, -- Minimum window width
  wrap = false, -- Disable line wrap

  list = false,
  listchars = {
    tab = "»·",
    nbsp = "+",
    trail = "·",
    extends = "→",
    precedes = "←",
    space = "·",
  },

  fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
  },
})
