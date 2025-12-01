local M = {}

local config = require("scout.config")
local defaults = config.defaults
local cfg = vim.deepcopy(defaults)

function M.tmux_picker()
  local snacks = require("scout.snacks")
  return snacks.tmux_picker(cfg)
end

function M.setup(opts)
  cfg = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
