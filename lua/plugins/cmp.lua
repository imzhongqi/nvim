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
      symbol_map = _Icons.kinds,
    },
    config = function(_, opts)
      require("lspkind").init(opts)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      "lukas-reineke/cmp-under-comparator",
      "davidsierradz/cmp-conventionalcommits",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "lukas-reineke/cmp-rg",
      "rcarriga/cmp-dap",
    },

    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require "cmp"
      local lspkind = require "lspkind"
      local luasnip = require "luasnip"
      local cmp_types = require "cmp.types.cmp"
      local ConfirmBehavior = cmp_types.ConfirmBehavior
      -- local SelectBehavior = cmp_types.SelectBehavior

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
          autocomplete = {
            cmp_types.TriggerEvent.TextChanged,
          },
        },

        window = {
          completion = {
            border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            col_offset = -3,
          },
          documentation = {
            max_width = 50,
            border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        formatting = {
          expandable_indicator = true,
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format {
            mode = "symbol",
            maxwidth = 80,
            ellipsis_char = "...", -- 
            show_labelDetails = true,
            before = function(entry, vim_item)
              -- vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
              return vim_item
            end,
          },
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp", keyword_length = 0 },
        }, {
          { name = "rg", keyword_length = 3 },
          { name = "buffer", keyword_length = 3 },
        }, {
          {
            name = "path",
          },
        }),

        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        preselect = cmp_types.PreselectMode.Item,
        mapping = cmp.mapping.preset.insert {
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),

          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.close(),
            c = cmp.mapping.close(),
          },
          ["<C-y>"] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = ConfirmBehavior.Replace, select = false },
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
          },
          ["<C-l>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.confirm { behavior = ConfirmBehavior.Replace, select = false }
            else
              cmp.complete()
            end
          end, { "i", "c" }),
          ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            -- elseif has_words_before() then
            --   cmp.complete()
            else
              fallback() --Fallback to tabout of `ultimate-autopair` as expected
            end
          end, {
            "i",
            "s",
            "c",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
        },

        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      }
    end,

    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      local cmp = require "cmp"
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      cmp.setup(opts)

      cmp.setup.cmdline(":", {
        completion = {
          completeopt = "menu,menuone,noinsert",
          autocomplete = false,
        },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        sources = cmp.config.sources({
          { name = "nvim_lsp_document_symbol" },
        }, {
          { name = "buffer", keyword_length = 3 },
        }),
      })

      cmp.setup.filetype({ "gitcommit", "NeogitCommitMessage" }, {
        sources = cmp.config.sources {
          { name = "conventionalcommits" },
          { name = "buffer" },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Setup cmp buffer dap source",
        pattern = { "dap-repl", "dapui_watches", "dapui_hover" },
        callback = function()
          cmp.setup.buffer {
            enabled = function()
              return vim.bo[0].buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
            end,
            sources = {
              { name = "dap" },
            },
          }
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Setup cmp buffer sql source",
        pattern = { "mysql", "sql" },
        callback = function()
          cmp.setup.buffer {
            sources = cmp.config.sources({
              { name = "vim-dadbod-completion" },
            }, {
              { name = "buffer" },
            }),
          }
        end,
      })
    end,
  },
}
