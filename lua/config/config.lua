local open_float = vim.diagnostic.open_float
vim.diagnostic.open_float = function(...)
  local _, win = open_float(...)
  vim.api.nvim_set_option_value("winhighlight", "NormalFloat:Normal", { win = win })
end
