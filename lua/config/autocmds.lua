-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "dap-float",
    "Jaq",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "Jaq",
  },
  callback = function()
    vim.api.nvim_buf_set_var(0, "miniindentscope_disable", true)
  end,
})
