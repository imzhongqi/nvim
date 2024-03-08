local M = {}

function M.keymaps_del(keymaps)
  for _, entry in ipairs(keymaps) do
    if type(entry) == "table" then
      local modes = type(entry[1]) == "string" and { entry[1] } or entry[1]
      if #modes > 0 then
        local keys = type(entry[2]) == "string" and { entry[2] } or entry[2]
        for _, key in ipairs(keys) do
          vim.keymap.del(modes, key, entry[3])
        end
      end
    end
  end
end

local keymap_set = function(entry)
  local mode = entry.mode or "n"
  local lhs = entry[1]
  local rhs = entry[2]
  local opts = M.opts(entry) ---@type vim.api.keyset.keymap

  opts.silent = opts.silent or true

  if entry.cond ~= nil then
    local condt = type(entry.cond)
    if (condt == "boolean" and entry.cond == false) or (condt == "function" and entry.cond() ~= nil) then
      return
    end
  end

  local ok, result = pcall(vim.keymap.set, mode, lhs, rhs, opts)
  if not ok then
    vim.notify "not ok "
  end
end

local skip = { mode = true, cond = true }

function M.opts(keys)
  local opts = {}
  for k, v in pairs(keys) do
    if type(k) ~= "number" and not skip[k] then
      opts[k] = v
    end
  end
  return opts
end

function M.keymaps_set(keymaps)
  for _, entry in pairs(keymaps) do
    keymap_set(entry)
  end
end

---@param opts vim.opt
function M.options_set(opts)
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

function M.has_suffix(str, suffix)
  local suffix_length = string.len(suffix)
  local str_length = string.len(str)
  if str_length < suffix_length then
    return false
  end
  local end_substring = string.sub(str, -suffix_length)
  return end_substring == suffix
end

local ESC_FEEDKEY = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

function M.get_visual_lines(bufnr)
  vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)
  vim.api.nvim_feedkeys("gv", "x", false)
  vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)

  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(bufnr, "<"))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(bufnr, ">"))
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, end_row, false)

  -- get whole buffer if there is no current/previous visual selection
  if start_row == 0 then
    lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    start_row = 1
    start_col = 0
    end_row = #lines
    end_col = #lines[#lines]
  end

  -- use 1-based indexing and handle selections made in visual line mode (see :help getpos)
  start_col = start_col + 1
  end_col = math.min(end_col, #lines[#lines] - 1) + 1

  -- shorten first/last line according to start_col/end_col
  lines[#lines] = lines[#lines]:sub(1, end_col)
  lines[1] = lines[1]:sub(start_col)

  return lines, start_row, start_col, end_row, end_col
end

function M.get_selected_text()
  local lines, _, _, _, _ = M.get_visual_lines(vim.api.nvim_get_current_buf())
  return table.concat(lines, "\n")
end

return M
