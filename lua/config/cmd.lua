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
  else
    local buf = vim.api.nvim_get_current_buf()
    if
      vim.fn.buflisted(buf) ~= 0
      and vim.api.nvim_buf_get_name(buf) ~= ""
      and not (vim.bo[buf].ft == "" and vim.bo[buf].bt == "")
    then
      return
    end

    vim.api.nvim_create_autocmd("BufHidden", {
      group = vim.api.nvim_create_augroup("_delete_hidden_buffer", { clear = true }),
      buffer = buf,
      once = true,
      callback = function()
        if not vim.bo[buf].modified then
          vim.bo[buf].buflisted = false
          vim.schedule(function() vim.api.nvim_buf_delete(buf, { force = true }) end)
        end
      end,
    })
  end
end, {
  desc = "Delete the buffer, but do not delete the buffer with an empty Buftype",
})
