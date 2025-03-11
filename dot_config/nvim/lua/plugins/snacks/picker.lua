local M = {}

---@type snacks.picker.Config
M.config = {
  enabled = true,
  layout = {
    preset = 'ivy',
    layout = {
      position = 'bottom',
    },
  },
  formatters = {
    file = {
      filename_first = true,
      truncate = 100,
    },
  },
  jump = {
    reuse_win = true,
  },
  sources = {
    buffers = {
      current = false,
    },
    explorer = {
      auto_close = true,
      jump = { close = true },
    },
  },
  win = {
    input = {
      keys = {
        ['<Esc>'] = { 'close', mode = { 'i', 'n' } },
      },
    },
  },
}

local function is_git_repo()
  vim.fn.system('git rev-parse --is-inside-work-tree')
  return vim.v.shell_error == 0
end

local function get_git_root()
  local dot_git_path = vim.fn.finddir('.git', '.;')
  return vim.fn.fnamemodify(dot_git_path, ':h')
end

function M.find_files_from_project_git_root()
  local opts = {
    hidden = true,
  }
  if is_git_repo() then vim.list_extend(opts, { cwd = get_git_root() }) end
  Snacks.picker.files(opts)
end

function M.live_grep_from_project_git_root()
  local opts = {}
  if is_git_repo() then opts = { cwd = get_git_root() } end
  Snacks.picker.grep(opts)
end

return M
