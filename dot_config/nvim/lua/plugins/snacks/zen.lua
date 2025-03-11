local M = {}

---@type snacks.zen.Config
M.config = {
  enabled = true,
  toggles = {
    dim = false,
    git_signs = false,
    mini_diff_signs = false,
  },
  show = {
    statusline = false,
    tabline = false,
  },
  win = { backdrop = { transparent = false } },
}

return M
