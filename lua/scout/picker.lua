---@class Scout.Picker
local M = {}

local config = require("scout.config")
---@type Scout.ConfigDefaults
local defaults = config.defaults
local cfg = vim.deepcopy(defaults)

---@return any|nil
function M.tmux_picker()
  local snacks = require("scout.snacks")
  return snacks.tmux_picker(cfg)
end

---@param opts table|nil
---@return nil
function M.setup(opts)
  cfg = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
