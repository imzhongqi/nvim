return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      {
        "onsails/lspkind.nvim",
        opts = {
          -- defines how annotations are shown
          -- default: symbol
          -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          mode = "symbol_text",

          -- default symbol map
          -- can be either 'default' (requires nerd-fonts font) or
          -- 'codicons' for codicon preset (requires vscode-codicons font)
          --
          -- default: 'default'
          preset = "codicons",

          -- override preset symbols
          --
          -- default: {}
          symbol_map = {
            Class = " ",
            Color = "󰏘 ",
            Constant = "󰏿 ",
            Constructor = " ",
            Enum = " ",
            Event = " ",
            EnumMember = " ",
            Field = "󰜢 ",
            File = "󰈙 ",
            Folder = "󰉋 ",
            Function = "󰊕 ",
            Interface = " ",
            Keyword = "󰌋 ",
            Method = "󰆧 ",
            Module = " ",
            Operator = "󰆕 ",
            Property = "󰜢 ",
            Snippet = " ",
            Struct = "󰙅 ",
            Text = "󰉿 ",
            TypeParameter = " ",
            Unit = "󰑭 ",
            Value = "󰎠 ",
            Variable = " ",
            Reference = "󰈇 ",
          },
        },
        config = function(_, opts)
          require("lspkind").init(opts)
        end,
      },
    },

    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_window = require("cmp.config.window")
      local lspkind = require("lspkind")
      local compare = require("cmp.config.compare")

      opts.window = {
        completion = cmp_window.bordered(),
        documentation = cmp_window.bordered(),
      }
      opts.formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = 30,
          ellipsis_char = "...", -- 
          show_labelDetails = true,
          before = function(entry, vim_item)
            -- vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
            return vim_item
          end,
        }),
      }
      opts.sorting = {
        comparators = {
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare.locality,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      }

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      })

      return opts
    end,

    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      local cmp = require("cmp")
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      local cmd_mapping = cmp.mapping.preset.cmdline()

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmd_mapping,
        sources = cmp.config.sources({
          { name = "buffer" },
        }, {
          { name = "path" },
        }),
      })

      cmp.setup.cmdline(":", {
        mapping = cmd_mapping,
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup(opts)
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = { "CursorMoved", "CursorHold", "InsertEnter" },
    },

    -- stylua: ignore
    keys = {
      {
        "<tab>",
        false,
        -- function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end, 
        -- expr = true, silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function() require("luasnip").jump(1) end,
        mode = "s",
      },
      {
        "<s-tab>",
        function() require("luasnip").jump(-1) end,
        mode = { "i", "s" },
      },
    },
  },
}
