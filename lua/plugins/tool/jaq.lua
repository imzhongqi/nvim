return {
  "is0n/jaq-nvim",
  keys = {
    { "<leader>ce", "<cmd>Jaq<cr>", desc = "run code" },
  },
  cmd = { "Jaq" },
  opts = {
    cmds = {
      -- Uses vim commands
      internal = {
        lua = "luafile %",
        vim = "source %",
      },

      -- Uses shell commands
      external = {
        markdown = "glow %",
        python = "python3 %",
        rust = "cargo run",
        go = "go run %",
        sh = "sh %",
      },
    },

    behavior = {
      default = "terminal",
      startinsert = false,
      wincmd = false,
      autosave = true,
    },

    ui = {
      terminal = {
        position = "bot",
        size = 10,
        line_no = false,
      },
    },
  },
  config = function(_, opts)
    local j = require "jaq-nvim"

    local fn = j.Jaq

    j.Jaq = function(type)
      if not type and opts.behavior.default == "terminal" then
        vim.iter(vim.api.nvim_list_bufs()):each(function(bufnr)
          if vim.bo[bufnr].filetype == "Jaq" then
            vim.api.nvim_buf_delete(bufnr, { force = true })
          end
        end)
      end
      fn(type)
    end

    j.setup(opts)
  end,
}
