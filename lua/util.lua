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

  opts.silent = opts.silent ~= false
  pcall(vim.keymap.set, mode, lhs, rhs, opts)
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
    if entry.cond ~= nil then
      local condt = type(entry.cond)
      if (condt == "boolean" and entry.cond ~= false) or (condt == "function" and entry.cond() ~= nil) then
        keymap_set(entry)
      end
    else
      keymap_set(entry)
    end
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

return M
