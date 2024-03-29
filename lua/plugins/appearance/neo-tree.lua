return {
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    opts = {
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify", "Trouble" },
          buftype = { "terminal", "quickfix" },
        },
      },
      show_prompt = false,
      highlights = {
        statusline = {
          focused = {
            fg = "#c8d3f5",
            bg = "#1e2030",
            bold = true,
          },
          unfocused = {
            fg = "#c8d3f5",
            bg = "#1e2030",
            bold = true,
          },
        },
        -- winbar = {
        --   focused = {
        --     fg = "#c8d3f5",
        --     bg = "#1e2030",
        --     bold = true,
        --   },
        --   unfocused = {
        --     fg = "#c8d3f5",
        --     bg = "#1e2030",
        --     bold = true,
        --   },
        -- },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window.mappings = vim.tbl_extend("force", opts.window.mappings, {
        ["<space>"] = "none",
        ["l"] = "open",

        ["O"] = {
          command = function(state)
            local node = state.tree:get_node()
            local filepath = node.path

            local osType = vim.uv.os_uname().sysname
            local command = "start"
            if osType == "Darwin" then
              command = "open"
            elseif osType == "Linux" then
              command = "xdg-open"
            end

            vim.uv.spawn(command, { args = { filepath }, deatched = true })
          end,
          desc = "open_with_system_defaults",
        },
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "kwkarlwang/bufresize.nvim",
      "s1n7ax/nvim-window-picker",
    },
    opts = {
      popup_border_style = "rounded",
      default_component_configs = {
        icon = {
          folder_closed = _Icons.ui.FolderClosed,
          folder_open = _Icons.ui.FolderOpen,
          folder_empty = _Icons.ui.FolderEmpty,
          default = _Icons.ui.FileDefault,
          highlight = "NeoTreeFileIcon",
        },
        modified = {
          symbol = "",
          highlight = "NeoTreeModified",
        },
        git_status = {
          symbols = {
            added = _Icons.git.added,
            modified = _Icons.git.modified,
            deleted = _Icons.git.deleted,
            renamed = _Icons.git.renamed,
            untracked = _Icons.git.untracked,
            ignored = _Icons.git.ignored,
            unstaged = _Icons.git.unstaged,
            staged = _Icons.git.staged,
            conflict = _Icons.git.conflict,
          },
        },
      },

      window = {
        width = 30,
      },

      event_handlers = {
        {
          event = "neo_tree_window_before_open",
          handler = function()
            require("bufresize").block_register()
          end,
        },
        {
          event = "neo_tree_window_after_open",
          handler = function()
            vim.g.neotree_opened = true
            require("bufresize").resize_open()
          end,
        },
        {
          event = "neo_tree_window_before_close",
          handler = function()
            require("bufresize").block_register()
          end,
        },
        {
          event = "neo_tree_window_after_close",
          handler = function()
            vim.g.neotree_opened = false
            require("bufresize").resize_close()
          end,
        },
      },

      filesystem = {
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,

        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
          show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            --"node_modules",
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json"
          },
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignore",
          },
        },
      },
    },
  },
}
