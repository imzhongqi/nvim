return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  keys = {
    {
      "<leader>mdd",
      "<cmd>DBUIToggle<CR>",
      desc = "Database UI",
    },
    {
      "<leader>mda",
      "<cmd>DBUIAddConnection<CR>",
      desc = "Add Connection",
    },
  },
  init = function()
    vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_use_nvim_notify = 1
    vim.g.db_ui_winwidth = 30
    vim.g.db_ui_notification_width = 20
    vim.g.db_ui_auto_execute_table_helpers = 1
    -- vim.g.db_ui_hide_schemas = {}
    vim.g.db_ui_icons = {
      expanded = {
        db = "  󰆼",
        buffers = "  ",
        saved_queries = "  ",
        schemas = "  ",
        schema = "  פּ",
        tables = "  󰓱",
        table = "  ",
      },
      collapsed = {
        db = "  󰆼",
        buffers = "  ",
        saved_queries = "  󰉋",
        schemas = "  ",
        schema = "  פּ",
        tables = "  󰓱",
        table = "  ",
      },

      saved_query = "",
      new_query = "󰐕",
      tables = "",
      buffers = "»",
      connection_ok = _Icons.misc.ok,
      connection_error = _Icons.misc.err,
    }

    vim.api.nvim_create_autocmd("Filetype", {
      group = vim.api.nvim_create_augroup("on_dbui_open", { clear = true }),
      pattern = "dbui",
      callback = function()
        vim.wo.foldenable = false
      end,
    })
  end,
}
