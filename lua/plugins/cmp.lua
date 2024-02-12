return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
    opts = {
      region_check_events = { "CursorMoved", "CursorHold", "InsertEnter", "CursorMoved" },
      delete_check_events = { "TextChanged", "InsertLeave" },
    },
  },

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

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_window = require("cmp.config.window")
      local cmp_compare = require("cmp.config.compare")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      opts.window = {
        completion = cmp_window.bordered({
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp_window.bordered({
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      }

      opts.formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = 80,
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
          cmp_compare.offset,
          cmp_compare.exact,
          cmp_compare.score,
          cmp_compare.recently_used,
          cmp_compare.locality,
          cmp_compare.kind,
          cmp_compare.sort_text,
          cmp_compare.length,
          cmp_compare.order,
        },
      }

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            -- cmp.complete()
            fallback()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,

        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false }
            local is_insert_mode = function()
              return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
            end
            if is_insert_mode() then -- prevent overwriting brackets
              confirm_opts.behavior = cmp.ConfirmBehavior.Insert
            end
            if cmp.confirm(confirm_opts) then
              return -- success, exit early
            end
          end
          fallback() -- if not exited early, always fallback
        end),
      })

      opts.cmdline = {
        {
          type = ":",
          sources = {
            { name = "path" },
            { name = "cmdline" },
          },
        },
        {
          type = { "/", "?" },
          sources = {
            { name = "buffer" },
          },
        },
      }

      return opts
    end,

    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      local cmp = require("cmp")
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      if opts.cmdline then
        for _, o in ipairs(opts.cmdline) do
          cmp.setup.cmdline(o.type, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = o.sources,
          })
        end
      end

      cmp.setup(opts)
    end,
  },
}
