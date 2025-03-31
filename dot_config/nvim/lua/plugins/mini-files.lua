-- Toggle dotfiles
local show_dotfiles = true
local filter_show = function(_) return true end
local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end
local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
  end,
})

-- Add commands for horizontal and vertical split
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      ---@diagnostic disable-next-line: redundant-return-value
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in({ close_on_file = true })
  end

  local desc = 'Split ' .. direction
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, '<C-s>', 'belowright horizontal')
    map_split(buf_id, '<C-v>', 'belowright vertical')
  end,
})

-- Add command for jumping to current file
local focus_target_file = function()
  local target_window = MiniFiles.get_explorer_state().target_window
  local target_buf_id = vim.api.nvim_win_get_buf(target_window)
  local current_file_path = vim.api.nvim_buf_get_name(target_buf_id)
  if vim.uv.fs_stat(current_file_path) == nil then
    return vim.notify('Current buffer not found in disk')
  end

  local paths = { current_file_path }
  for dir in vim.fs.parents(current_file_path) do
    table.insert(paths, 1, dir)
    if dir == vim.env.PWD then break end
  end

  MiniFiles.set_branch(paths)
end
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    vim.keymap.set(
      'n',
      ',',
      focus_target_file,
      { buffer = args.data.buf_id, desc = 'Focus current buffer' }
    )
  end,
})

-- Init module
require('mini.files').setup({
  windows = {
    preview = true,
    width_preview = 50,
  },
})

vim.keymap.set('n', '<C-p>', function()
  if not MiniFiles.close() then MiniFiles.open() end
end, { desc = 'Toggle file explorer' })
