return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics = {
      virtual_text = false,
      float = {
        border = "rounded",
      },
    }

    local libs = vim.api.nvim_get_runtime_file("", true)
    table.insert(libs, vim.fn.expand("~/.local/share/nvim/dev"))
    opts.servers = vim.tbl_deep_extend("force", opts.servers, {
      lua_ls = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        -- Use this to add any additional keymaps
        -- for specific lsp servers
        ---@type LazyKeysSpec[]
        -- keys = {},
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              library = libs,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    })
  end,
}
