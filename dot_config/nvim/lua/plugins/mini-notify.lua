require('mini.notify').setup({
  lsp_progress = {
    duration_last = 5000,
  },
})

vim.notify = require('mini.notify').make_notify()

local create_notification_win = function()
  local notifications = MiniNotify.get_all()
  table.sort(notifications, function(a, b) return a.ts_update < b.ts_update end)
  local content = vim
    .iter(notifications)
    :map(
      function(n) return vim.fn.strftime('%H:%M:%S', math.floor(n.ts_update)) .. ' | ' .. n.msg end
    )
    :totable()

  -- Calculate longest line
  local line_widths = vim.iter(content):map(string.len):totable()
  local line_width = 1
  for _, l_w in ipairs(line_widths) do
    line_width = math.max(line_width, l_w)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.keymap.set('n', 'q', vim.cmd.close, { buffer = buf })

  local ui = vim.api.nvim_list_uis()[1]
  local width = math.min(line_width, math.floor(0.5 * ui.width))

  local height = 0
  for _, l_w in ipairs(line_widths) do
    height = height + math.floor(math.max(l_w - 1, 0) / width) + 1
  end
  height = math.min(height, math.floor(0.5 * ui.height))

  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = (ui.width / 2) - (width / 2),
    row = (ui.height / 2) - (height / 2),
    anchor = 'NW',
    border = 'rounded',
    style = 'minimal',
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

  vim.bo[buf].readonly = true
  vim.api.nvim_open_win(buf, true, opts)
end

vim.keymap.set('n', '<Leader>ns', create_notification_win, { desc = 'Notification history' })
