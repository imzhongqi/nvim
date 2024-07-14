local Util = require "util"
local with_suffix = function(name) return name .. _Icons.fzflua.suffix end

local function history_path(filename) return Util.stdpath("cache", filename) end

local switch_cwd = function(_, opts)
  local cwd = vim.uv.cwd()
  if not opts.cwd or opts.cwd == cwd then
    cwd = require("lazyvim.util").root.get()
  end
  opts.__call_fn {
    resume = true,
    cwd = cwd,
  }
end

local function replace_prompt(o)
  if o.prompt and type(o.prompt) == "string" then
    local prompt_name = o.prompt:match "(%w+)> "
    if prompt_name then
      o.prompt = with_suffix(prompt_name)
    end
  end

  if type(o) == "table" then
    for k, v in pairs(o) do
      if type(k) == "string" and k:match "^%w" and type(v) == "table" then
        replace_prompt(v)
      end
    end
  end
end

return {
  "ibhagwan/fzf-lua",
  cmd = { "FzfLua" },
  keys = {
    { "<leader>fr", "<cmd>FzfLua resume<CR>", desc = "FzfLua resume" },
    { "<C-S-p>", "<cmd>FzfLua builtin<CR>", desc = "FzfLua builtin", mode = { "n", "v" } },
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
      function()
        require("fzf-lua").git_files {
          cwd = require("lazyvim.util").root(),
        }
      end,
      desc = "FzfLua git files",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").live_grep_glob {
          cwd = require("lazyvim.util").root(),
        }
      end,
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
          ["<C-S-j>"] = "preview-page-down",
          ["<C-S-k>"] = "preview-page-up",
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
          ["ctrl-x"] = switch_cwd,
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

      previewers = {
        codeaction_native = {
          pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit" --syntax-theme=TwoDark --minus-style='#ffffff "#2f2837"' --plus-style='#ffffff "#26343c"']],
        },
      },

      buffers = {
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
        tab_marker = "",
      },

      files = {
        fzf_opts = {
          ["--history"] = history_path "fzf-lua-files-history",
        },
      },

      oldfiles = {
        cwd_only = false,
        stat_file = true, -- verify files exist on disk
        include_current_session = false, -- include bufs from current session
      },

      grep = {
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
      },

      lsp = {
        prompt_postfix = _Icons.fzflua.suffix,
        cwd_only = false,
        symbols = {
          prompt_postfix = _Icons.fzflua.suffix,
          symbol_icons = _Icons.kinds,
        },
        code_actions = {
          previewer = "codeaction_native",
        },
      },
    }
  end,

  config = function(_, opts)
    require("fzf-lua.config")._action_to_helpstr[switch_cwd] = "switch-cwd"

    replace_prompt(require("fzf-lua.defaults").defaults)

    local fzf = require "fzf-lua"
    fzf.setup(opts, true)
    fzf.register_ui_select()
  end,
}
