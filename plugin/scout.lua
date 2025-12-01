-- Loads the plugin and keymaps
if vim.g.loaded_scout then
  return
end
vim.g.loaded_scout = true

require("scout").setup()
