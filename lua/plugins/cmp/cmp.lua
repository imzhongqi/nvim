return {
  { "rcarriga/cmp-dap" },

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
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "lukas-reineke/cmp-under-comparator",
      "lukas-reineke/cmp-rg",
      -- "ray-x/cmp-treesitter",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Setup cmp buffer dap source",
        pattern = { "dap-repl", "dapui_watches", "dapui_hover" },
        callback = function()
          local cmp = require "cmp"
          cmp.setup.buffer {
            enabled = function() return vim.bo[0].buftype ~= "prompt" or require("cmp_dap").is_dap_buffer() end,
            sources = cmp.config.sources {
              { name = "dap" },
            },
          }
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Setup cmp buffer sql source",
        pattern = { "mysql", "sql" },
        callback = function()
          local cmp = require "cmp"
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
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require "cmp"
      local lspkind = require "lspkind"
      local luasnip = require "luasnip"

      local has_words_before = function()
        if vim.api.nvim_get_option_value("buftype", {}) == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
      end

      return {
        completion = {
          ---@usage The minimum length of a word to complete on.
          keyword_length = 1,
          completeopt = "menu,menuone,noinsert",
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
          },
        },

        window = {
          completion = {
            border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            col_offset = -3,
          },
          documentation = {
            -- max_width = 100,
            border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },

        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
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
              vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
              return vim_item
            end,
          },
        },

        sources = {
          {
            name = "copilot",
            group_index = 2,
            -- keyword_length = 0,
            max_item_count = 3,
            trigger_characters = {
              {
                ".",
                ":",
                "(",
                "'",
                '"',
                "[",
                ",",
                "#",
                "*",
                "@",
                "|",
                "=",
                "-",
                "{",
                "/",
                "\\",
                "+",
                "?",
                " ",
                -- "\t",
                -- "\n",
              },
            },
          },
          {
            name = "nvim_lsp",
            -- keyword_length = 1,
          },
          {
            name = "luasnip",
            group_index = 2,
            keyword_length = 2,
          },
          {
            name = "path",
            group_index = 2,
          },
          {
            name = "buffer",
            group_index = 2,
            keyword_length = 3,
          },
          -- { name = "treesitter", group_index = 2 },
          {
            name = "rg",
            group_index = 2,
            keyword_length = 3,
          },
        },

        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,

            cmp.config.compare.offset,
            cmp.config.compare.exact,
            -- cmp.config.compare.scopes,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        preselect = cmp.PreselectMode.Item,
        mapping = cmp.mapping.preset.insert {
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),

          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.close(),
            c = cmp.mapping.close(),
          },
          ["<C-y>"] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
          },
          ["<C-l>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
            else
              cmp.complete()
            end
          end, { "i", "c" }),
          ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              -- cmp.select_next_item()
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            -- elseif luasnip.expand_or_locally_jumpable() then
            --   luasnip.expand_or_jump()
            -- elseif has_words_before() then
            --   cmp.complete()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
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
            -- elseif luasnip.jumpable(-1) then
            --   luasnip.jump(-1)
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
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

      cmp.setup(opts)

      cmp.setup.cmdline(":", {
        completion = {
          completeopt = "menu,menuone,noinsert",
          -- autocomplete = true,
        },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        sources = cmp.config.sources({
          { name = "buffer" },
        }, {
          { name = "nvim_lsp_document_symbol" },
        }),
      })
    end,
  },
}
