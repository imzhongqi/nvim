vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable LazyVim auto format
vim.g.autoformat = true

vim.g.root_spec = { "lsp", { ".git", "lua", "README.md", "Cargo.toml", "Makefile", "src" }, "cwd" }

require("util").options_set {
  autowrite = true, -- Enable auto write

  backup = false,
  writebackup = false,
  swapfile = true,

  undofile = true,

  undodir = _Util.stdpath("cache", "undo"),

  clipboard = "unnamedplus", -- Sync with system clipboard
  completeopt = "menu,menuone,noselect",
  conceallevel = 2, -- Hide * markup for bold and italic
  confirm = true, -- Confirm to save changes before exiting modified buffer
  cursorline = true, -- Enable highlighting of the current line
  -- sessionoptions = "buffers,curdir,folds,help,winsize,terminal",

  expandtab = true, -- Use spaces instead of tabs
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,

  formatoptions = "jcroqlnt",

  foldcolumn = "1",
  foldlevel = 99,
  foldlevelstart = 99,
  foldenable = true,

  pumblend = 0,
  pumheight = 10,

  ignorecase = true, -- Ignore case
  inccommand = "nosplit", -- preview incremental substitute

  laststatus = 3, -- global statusline

  relativenumber = true,

  number = true,

  mousemoveevent = true,

  timeoutlen = 500,
  termguicolors = true, -- True color support

  sessionoptions = "buffers,curdir,folds,help,tabpages,winpos",
  shiftround = true,
  smartcase = true, -- Don't ignore case with capitals
  smartindent = true, -- Insert indents automatically

  spell = false,
  spelllang = { "en_us" },

  showmode = false, -- Dont show mode since we have a statusline
  sidescrolloff = 8, -- Columns of context
  signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
  shortmess = function(opt) opt:append { W = true, I = true, c = true, C = true } end,

  undolevels = 10000,
  updatetime = 200, -- Save swap file and trigger CursorHold

  virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode

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
}
