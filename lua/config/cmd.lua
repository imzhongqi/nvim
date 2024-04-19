vim.api.nvim_create_user_command("BufRemove", function()
  require("mini.bufremove").delete()
  local wins = vim
    .iter(vim.api.nvim_list_wins())
    :map(function(id) return { id = id, config = vim.api.nvim_win_get_config(id) } end)
    :filter(function(w)
      -- only filter split windows
      if w.config.split then
        -- only close main windows
        return vim.bo[vim.api.nvim_win_get_buf(w.id)].buftype == ""
      end
      return false
    end)
    :totable()
  if #wins > 1 then
    pcall(vim.api.nvim_win_close, 0, true)
  end
end, {
  desc = "Delete the buffer, but do not delete the buffer with an empty Buftype",
})
