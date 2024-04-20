vim.api.nvim_create_user_command("BufRemove", function()
  require("mini.bufremove").delete()
  local current_tabpage = vim.api.nvim_get_current_tabpage()
  local wins = vim
    .iter(vim.api.nvim_list_wins())
    :map(
      function(id)
        return {
          id = id,
          tabpage = vim.api.nvim_win_get_tabpage(id),
          config = vim.api.nvim_win_get_config(id),
        }
      end
    )
    :filter(
      function(w)
        return w.tabpage == current_tabpage and w.config.split and vim.bo[vim.api.nvim_win_get_buf(w.id)].buftype == ""
      end
    )
    :totable()
  if #wins > 1 then
    pcall(vim.api.nvim_win_close, 0, true)
  end
end, {
  desc = "Delete the buffer, but do not delete the buffer with an empty Buftype",
})
