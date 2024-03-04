return {
  -- { "simrat39/rust-tools.nvim", enabled = false },

  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, opts)
          return true
        end,
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "folke/noice.nvim",
      {
        "nvim-neotest/neotest",
        opts = {
          adapters = {
            ["rustaceanvim.neotest"] = {},
          },
        },
      },
    },
    version = "^4",
    ft = { "rust" },
    opts = function()
      vim.g.rustaceanvim = {
        tools = {
          code_actions = {
            --- whether to fall back to `vim.ui.select` if there are no grouped code actions
            ---@type boolean
            ui_select_fallback = true,
          },

          float_win_config = {
            border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
            max_width = 120,
            max_height = 20,
          },
        },

        server = {
          on_attach = function(_, bufnr)
            require("util").keymaps_set {
              { "K", "<cmd>RustLsp hover<cr>", { desc = "Hover Actions (Rust)", buffer = bufnr } },
              { "<leader>cR", "<cmd>RustLsp codeAction<cr>", { desc = "Code Action (Rust)", buffer = bufnr } },
              {
                "<leader>dr",
                "<cmd>RustLsp debuggables<cr>",
                { desc = "Run Debuggables (Rust)", buffer = bufnr },
              },
            }
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                enable = false,
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      }
    end,
    config = function() end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
      end
    end,
  },
}
