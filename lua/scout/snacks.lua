local M = {}
local util = require("scout.util")

function M.tmux_picker(cfg)
  local Snacks = require("snacks")
  local activeHL = cfg.highlight_active
  local inactiveHL = cfg.highlight_inactive

  local active_session = vim.fn.systemlist("tmux display-message -p '#S' 2>/dev/null")[1] or ""
  local items = {}

  -- Existing tmux sessions
  local output = vim.fn.systemlist("tmux list-sessions -F '#{session_name} #{session_path}' 2>/dev/null")
  for _, line in ipairs(output) do
    local name, path = line:match("([^ ]+) (.+)")
    if name and path and name ~= active_session then
      table.insert(items, {
        data = { path = path, name = name, existing = true },
        text = string.format("[TMUX] %s (%s)", name, path),
      })
    end
  end

  local existing_names = vim.tbl_map(function(item)
    return item.data.name
  end, items)

  -- Search folders for potential new sessions
  for _, dir in ipairs(cfg.search_paths) do
    local expanded = util.expand(dir)
    local ok, list = pcall(vim.fn.readdir, expanded)
    if ok and list then
      for _, d in ipairs(list) do
        local full = expanded .. "/" .. d
        if vim.fn.isdirectory(full) == 1 then
          local name = d:gsub("%.", "_")
          if name ~= active_session and not vim.tbl_contains(existing_names, name) then
            table.insert(items, {
              data = { path = full, name = name, existing = false },
              text = full,
            })
          end
        end
      end
    end
  end

  -- Extra include folders
  for _, dir in ipairs(cfg.include_folders) do
    local expanded = util.expand(dir)
    local name = vim.fn.fnamemodify(expanded, ":t"):gsub("%.", "_")
    if name ~= active_session and not vim.tbl_contains(existing_names, name) then
      table.insert(items, {
        data = { path = expanded, name = name, existing = false },
        text = expanded,
      })
    end
  end

  -- Exclusions
  for _, dir in ipairs(cfg.exclude_folders) do
    local expanded = util.expand(dir)
    items = vim.tbl_filter(function(item)
      return item.data.path ~= expanded
    end, items)
  end

  return Snacks.picker.pick({
    finder = function()
      return items
    end,

    format = function(item)
      if item.data.existing then
        return { { "[TMUX] " .. item.data.name, activeHL } }
      else
        return { { item.data.name, inactiveHL } }
      end
    end,

    confirm = function(picker, item)
      picker:close()
      if not item then
        return
      end

      if item.data.existing then
        util.run_tmux({ "switch-client", "-t", item.data.name })
      else
        util.run_tmux({ "new-session", "-ds", item.data.name, "-c", item.data.path })
        util.run_tmux({ "switch-client", "-t", item.data.name })
      end
    end,

    preview = function(ctx)
      ctx.preview:reset()
      if not ctx.item then
        ctx.preview:set_title("No selection")
        return
      end
      ctx.preview:set_title(cfg.preview.title)
      local content = vim.fn.systemlist(cfg.preview.cmd .. " " .. ctx.item.data.path)
      ctx.preview:set_lines(content)
    end,

    layout = cfg.layout,
  })
end

return M
