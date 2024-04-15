local Util = require "util"
local with_suffix = function(name) return name .. _Icons.fzflua.suffix end

local function history_path(filename) return Util.stdpath("cache", filename) end

return {
  "ibhagwan/fzf-lua",
  cmd = { "FzfLua" },
  keys = {
    { "<leader>fr", "<cmd>FzfLua resume<CR>", desc = "FzfLua resume" },
    { "<C-S-p>", "<cmd>FzfLua builtin<CR>", desc = "FzfLua builtin" },
    {
      "<leader>,",
      function() require("fzf-lua").buffers {} end,
      desc = "FzfLua buffers",
    },
    {
      "<leader><leader>",
      function()
        require("fzf-lua").files {
          cwd = require("lazyvim.util").root(),
        }
      end,
      desc = "FzfLua files",
    },
    {
      "<leader>ff",
      [[<cmd>lua require("fzf-lua").git_files { cwd = require("lazyvim.util").root() }<CR>]],
      desc = "FzfLua git files",
    },
    {
      "<leader>fg",
      function() require("fzf-lua").live_grep_glob { cwd = require("lazyvim.util").root() } end,
      desc = "FzfLua live grep",
    },
  },
  opts = function()
    local actions = require "fzf-lua.actions"

    return {
      winopts = {
        height = 0.85,
        width = 0.90,
        row = 0.35,
        col = 0.5,
        border = "rounded",
        preview = {
          default = "builtin",
          border = "border",
          wrap = "nowrap",
          hidden = "nohidden",
          vertical = "down:45%",
          horizontal = "right:65%",
        },
      },
      fzf_opts = {
        ["--ansi"] = true,
        ["--info"] = "inline-right",
        ["--height"] = "100%",
        ["--layout"] = "reverse",
        ["--border"] = "none",
        ["--tabstop"] = 2,
        ["--pointer"] = _Icons.fzflua.pointer,
        ["--scrollbar"] = _Icons.fzflua.scrollbar,
        ["--marker"] = _Icons.fzflua.marker,
      },
      hls = {
        normal = "Normal",
        border = "FzfLuaBorder",
        title = "FloatTitle",
        preview_normal = "Normal",
        preview_border = "FzfLuaBorder",
        preview_title = "FloatTitle",
      },
      fzf_colors = {
        ["fg"] = { "fg", "CursorLine" },
        ["bg"] = { "bg", "Normal" },
        ["hl"] = { "fg", "Statement" },
        ["fg+"] = { "fg", "Normal" },
        ["bg+"] = { "bg", "CursorLine" },
        ["hl+"] = { "fg", "Statement" },
        ["info"] = { "fg", "PreProc" },
        ["prompt"] = { "fg", "Conditional" },
        ["pointer"] = { "fg", "Exception" },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" },
        ["gutter"] = { "bg", "Normal" },
        ["separator"] = { "fg", "FzfLuaBorder" },
        ["scrollbar"] = { "fg", "FzfLuaBorder" },
        ["border"] = { "fg", "FzfLuaBorder" },
      },

      keymap = {
        builtin = {
          ["<C-h>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-up>"] = "preview-page-up",
          ["<S-down>"] = "preview-page-down",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          ["ctrl-f"] = "half-page-down",
          ["ctrl-d"] = "half-page-up",
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      actions = {
        files = {
          ["default"] = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["alt-q"] = actions.file_sel_to_qf,
          ["alt-l"] = actions.file_sel_to_ll,
        },
        buffers = {
          ["default"] = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
        },
        highlights = {
          ["default"] = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
        },
      },

      builtin = {
        prompt = with_suffix "Builtin",
      },

      previewers = {
        codeaction_native = {
          pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit" --syntax-theme=TwoDark --minus-style='#ffffff "#2f2837"' --plus-style='#ffffff "#26343c"']],
        },
      },

      buffers = {
        prompt = with_suffix "Buffers",
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
        show_unloaded = true, -- show unloaded buffers
        cwd_only = false, -- buffers for the cwd only
        actions = {
          ["ctrl-x"] = { fn = actions.buf_del, reload = true },
        },
      },

      tabs = {
        prompt = with_suffix "Tabs",
        tab_marker = "",
      },

      files = {
        prompt = with_suffix "Files",
        fzf_opts = {
          ["--history"] = history_path "fzf-lua-files-history",
        },
      },

      oldfiles = {
        prompt = with_suffix "History",
        cwd_only = false,
        stat_file = true, -- verify files exist on disk
        include_current_session = false, -- include bufs from current session
      },
      commands = {
        prompt = with_suffix "Commands",
      },

      grep = {
        prompt = with_suffix "Rg",
        input_prompt = with_suffix "Grep For",
        search = "",
        rg_glob = true, -- default to glob parsing?
        glob_flag = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
        fzf_opts = {
          ["--history"] = history_path "fzf-lua-grep-history",
        },
        actions = {
          ["ctrl-g"] = { actions.grep_lgrep },
          ["ctrl-r"] = { actions.toggle_ignore },
        },
      },

      git = {
        icons = {
          ["A"] = { icon = _Icons.fzflua.git.added, color = "green" },
          ["M"] = { icon = _Icons.fzflua.git.modified, color = "yellow" },
          ["D"] = { icon = _Icons.fzflua.git.deleted, color = "red" },
        },

        files = {
          prompt = with_suffix "GitFiles",
        },
      },

      changes = {
        prompt = with_suffix "Changes",
      },

      diagnostics = {
        prompt = with_suffix "Diagnostics",
      },

      highlights = {
        prompt = with_suffix "Highlights",
      },

      lsp = {
        prompt_postfix = _Icons.fzflua.suffix,
        cwd_only = false,
        symbols = {
          prompt_postfix = _Icons.fzflua.suffix,
          symbol_icons = _Icons.kinds,
        },
        finder = {
          prompt = with_suffix "LSP Finder",
        },
        code_actions = {
          prompt = with_suffix "Code Actions",
          previewer = "codeaction_native",
        },
      },
    }
  end,

  config = function(_, opts)
    local fzf = require "fzf-lua"
    fzf.setup(opts)
    fzf.register_ui_select()
  end,
}
