# scout.nvim

`scout.nvim` is a lightweight Neovim plugin that provides an **in-editor tmux session picker**, allowing you to easily switch to or create tmux sessions without leaving Neovim. It supports scanning existing tmux sessions, searching user-configured directories, and offers a flexible, configurable picker interface.

---

## Features

* Scan existing tmux sessions and present them in a picker UI.
* Search user-defined `search_paths` and `include_folders`, with support for `exclude_folders`.
* Configurable picker backend: `"snacks"` (default) or `"telescope"`.
* Flexible picker layout and preview configuration, with default directory preview using `ls -la`.
* Utilities to expand paths (`~`) and run tmux commands from Lua helpers.
* Fully configurable defaults via `require("scout").setup(opts)`.

---

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "chriso345/scout.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  -- Default configuration
  opts = {
    search_paths = { "~/projects" },   -- Paths to scan for tmux sessions
    include_folders = {},              -- Extra folders to include
    exclude_folders = {},              -- Folders to ignore
    picker = "snacks",                 -- Picker backend: "snacks" or "telescope"
    layout = {                         -- Default layout configuration (for snacks picker)
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
      cmd = "ls -la",                  -- Command to generate preview content
    },
    highlight_active = "SnacksPickerDirectory",
    highlight_inactive = "SnacksPickerPathHidden",
  },
  keys = {
    { "<C-f>", function() require("scout.picker").tmux_picker() end, desc = "Tmux Session Picker" },
  },
}
```

---

## Usage

The main API provides a **tmux session picker**:

```lua
-- Open the tmux session picker
require("scout.picker").tmux_picker()
```

---

## License

scout.nvim is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
