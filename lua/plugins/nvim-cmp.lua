return {
  "hrsh7th/nvim-cmp",

  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require("cmp")
    local cmp_window = require("cmp.config.window")

    opts.window = {
      completion = cmp_window.bordered({ scrollbar = false }),
      documentation = cmp_window.bordered(),
    }

    local icons = require("core.icons").kind

    opts.formatting = {
      expandable_indicator = true,
      fields = { "kind", "abbr", "menu" },
      format = function(_, vim_item)
        local max_width = 32
        if max_width ~= 0 and #vim_item.abbr > max_width then
          vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. ""
        end
        vim_item.kind = icons[vim_item.kind]
        vim_item.menu = "" -- disable show the menu
        return vim_item
      end,
    }

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    })

    return opts
  end,
}
