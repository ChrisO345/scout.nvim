local M = {}

function M.setup(opts)
  opts = opts or {}
  require("scout.picker").setup(opts)

  -- Default keymap
  vim.keymap.set("n", "<C-f>", require("scout.picker").tmux_picker, {
    noremap = true,
    silent = true,
    desc = "Open scout tmux picker",
  })
end

return M
