local M = {}

M.defaults = {
  highlight_active = "SnacksPickerDirectory",
  highlight_inactive = "SnacksPickerPathHidden",

  search_paths = {
    "~/projects", -- add your default search paths here
  },

  include_folders = {}, -- none
  exclude_folders = {}, -- none,

  picker = "snacks",    -- "snacks" | "telescope"

  -- Layout customization for snacks picker
  layout = {
    layout = {
      box = "horizontal",
      width = 0.8,
      min_width = 120,
      height = 0.8,
      {
        box = "vertical",
        border = true,
        title = " Tmux Sessions ",
        { win = "input", height = 1,     border = "bottom" },
        { win = "list",  border = "none" },
      },
      { win = "preview", title = " Directory ", border = true, width = 0.5 },
    },
  },

  preview = {
    cmd = "eza --tree --icons=always --group-directories-first -L 1",
    title = "Directory Tree",
    window_title = " Directory ",
  },
}

return M
