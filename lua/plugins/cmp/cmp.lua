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
              { name = "copilot" },
              { name = "vim-dadbod-completion" },
            }, {
              { name = "buffer" },
            }),
          }
        end,
      })
    end,

    opts = function(_, opts)
      local cmp = require "cmp"
      local lspkind = require "lspkind"

      opts.window = {
        completion = {
          border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
          winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          col_offset = -2,
        },
        documentation = {
          -- max_width = 100,
          border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
          winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      }

      opts.formatting = {
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
      }

      table.insert(opts.sources, { name = "rg" })
      table.insert(opts.sources, { name = "calc" })

      opts.sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          require("cmp-under-comparator").under,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }

      opts.mapping = cmp.mapping.preset.insert {
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
      }
    end,

    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      local cmp = require "cmp"

      cmp.setup(opts)
      local Kind = cmp.lsp.CompletionItemKind
      cmp.event:on("confirm_done", function(event)
        if not vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
          return
        end
        local entry = event.entry
        local item = entry:get_completion_item()
        if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) and item.insertTextFormat ~= 2 then
          local cursor = vim.api.nvim_win_get_cursor(0)
          local prev_char = vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1, {})[1]
          if prev_char ~= "(" and prev_char ~= ")" then
            local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
            vim.api.nvim_feedkeys(keys, "i", true)
          end
        end
      end)

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
