---@class Scout.util

local M = {}

---@param path string
---@return string
function M.expand(path)
  local expanded = path:gsub("^~", os.getenv("HOME") or "~")
  return expanded
end

---@param args string[]
---@return nil
function M.run_tmux(args)
  ---@diagnostic disable-next-line: missing-fields
  vim.uv.spawn("tmux", {
    args = args,
    stdio = { 0, 1, 2 },
  }, function() end)
end

---@return table
return M
