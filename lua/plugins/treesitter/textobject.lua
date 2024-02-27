return {
  {
    "echasnovski/mini.ai",
    opts = function()
      local ai = require("mini.ai")
      return {
        search_method = "cover",
        silent = true,

        n_lines = 1000,

        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer", "@assignment.outer", "@call.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner", "@assignment.inner", "@call.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          C = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          ["/"] = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "ghostbuster91/nvim-next",
    },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = { query = "@parameter.outer", desc = "a argument" },
            ["ia"] = { query = "@parameter.inner", desc = "inner part of a argument" },
            ["af"] = { query = "@function.outer", desc = "a function region" },
            ["if"] = { query = "@function.inner", desc = "inner part of a function region" },
            ["ar"] = { query = "@return.outer", desc = "a return" },
            ["ir"] = { query = "@return.outer", desc = "inner return" },
            ["ac"] = { query = "@class.outer", desc = "a of a class" },
            ["ic"] = { query = "@class.inner", desc = "inner part of a class region" },
            ["aj"] = { query = "@conditional.outer", desc = "a judge" },
            ["ij"] = { query = "@conditional.inner", desc = "inner part of a judge region" },
            ["al"] = { query = "@loop.outer", desc = "a loop" },
            ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
          },
        },
      },

      nvim_next = {
        enable = true,
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]a"] = { query = "@parameter.outer", desc = "Next argument start" },
              ["]f"] = { query = "@function.outer", desc = "Next function start" },
              ["]r"] = { query = "@function.outer", desc = "Next return start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]j"] = { query = "@conditional.outer", desc = "Next judge start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            },
            goto_next_end = {
              ["]A"] = { query = "@parameter.outer", desc = "Next argument end" },
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
              ["]R"] = { query = "@function.outer", desc = "Next return end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]J"] = { query = "@conditional.outer", desc = "Next judge end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[a"] = { query = "@parameter.outer", desc = "Previous argument start" },
              ["[f"] = { query = "@function.outer", desc = "Previous function start" },
              ["[r"] = { query = "@function.outer", desc = "Previous return start" },
              ["[c"] = { query = "@class.outer", desc = "Previous class start" },
              ["[j"] = { query = "@conditional.outer", desc = "Previous judge start" },
              ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
            },
            goto_previous_end = {
              ["[A"] = { query = "@parameter.outer", desc = "Previous argument end" },
              ["[F"] = { query = "@function.outer", desc = "Previous function end" },
              ["[R"] = { query = "@function.outer", desc = "Previous return end" },
              ["[C"] = { query = "@class.outer", desc = "Previous class end" },
              ["[J"] = { query = "@conditional.outer", desc = "Previous judge end" },
              ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
            },
          },
        },
      },
    },

    config = function(_, opts)
      require("nvim-next.integrations").treesitter_textobjects()
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
