local uv = vim.uv

local M = {}

function M.expand(path)
  return path:gsub("^~", os.getenv("HOME") or "~")
end

function M.run_tmux(args)
  uv.spawn("tmux", { args = args }, function() end)
end

return M
