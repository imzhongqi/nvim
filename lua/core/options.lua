local M = {}

---@param opts vim.opt
function M.set(opts)
  for k, v in pairs(opts) do
    if type(v) == "function" then
      local ret = v(vim.opt[k])
      if ret then
        vim.opt[k] = ret
      end
    else
      vim.opt[k] = v
    end
  end
end

return M
