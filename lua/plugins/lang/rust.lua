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
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
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
      "neovim/nvim-lspconfig",
    },
    version = "^4",
    ft = { "rust" },
    keys = {
      { "K", "<cmd>RustLsp hover<cr>", desc = "Hover Actions (Rust)" },
      { "<leader>cR", "<cmd>RustLsp codeAction<cr>", desc = "Code Action (Rust)" },
      { "<leader>dr", "<cmd>RustLsp debuggables<cr>", desc = "Run Debuggables (Rust)" },
    },
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find("Windows") then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has("mac") == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
      end

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

        dap = {
          adapter = adapter,
          configuration = {},
        },
        server = {
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

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
  },
}
