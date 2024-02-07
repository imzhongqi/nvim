return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local opts = {
        yaml = {
          query = vim.treesitter.query.parse(
            "yaml",
            [[
                (
                    (comment) @dash
                    (#match? @dash "^# ---+$")
                )
            ]]
          ),
          dash_highlight = "Dash",
        },
      }

      for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
        opts[ft] = {
          headline_highlights = {},
        }
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end

      opts.markdown.quote_string = "▌"

      return opts
    end,
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
}
