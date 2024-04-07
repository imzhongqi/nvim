local util = require "util"
local api = vim.api
local create_autocmd = vim.api.nvim_create_autocmd

local function augroup(name) return vim.api.nvim_create_augroup("user_" .. name, { clear = true }) end

create_autocmd("FileType", {
  group = augroup "close_with_q",
  pattern = {
    "dap-float",
    "Jaq",
    "vim",
    "git",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

create_autocmd("FileType", {
  pattern = {
    "Jaq",
  },
  callback = function() vim.api.nvim_buf_set_var(0, "miniindentscope_disable", true) end,
})

create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand "%" ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command "silent w"
    end
  end,
})

local function lazyvim_augroup(name) return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true }) end

create_autocmd("FileType", {
  group = lazyvim_augroup "wrap_spell",
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

create_autocmd("FileType", {
  group = augroup "markdown_with_wrap",
  pattern = { "markdown" },
  callback = function() vim.opt_local.wrap = true end,
})

create_autocmd("FileType", {
  group = augroup "set_window_highlight_with_filetype",
  pattern = { "neotest-output" },
  callback = function() vim.wo.winhighlight = "NormalFloat:Normal" end,
})

create_autocmd("TermOpen", {
  pattern = { "term://*" },
  callback = function()
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0 })
    -- vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { buffer = 0 })
    vim.keymap.set("t", "<C-S-h>", [[<Cmd>wincmd h<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-S-j>", [[<Cmd>wincmd j<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-S-k>", [[<Cmd>wincmd k<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-S-l>", [[<Cmd>wincmd l<CR>]], { buffer = 0 })
  end,
})
