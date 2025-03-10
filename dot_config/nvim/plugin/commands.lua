-- CloseHiddenBuffers
local function CloseHiddenBuffers()
  local non_hidden_bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    non_hidden_bufs[vim.api.nvim_win_get_buf(win)] = true
  end

  local buffers = vim.api.nvim_list_bufs()

  if #buffers == #non_hidden_bufs then return end

  for _, buffer in ipairs(buffers) do
    if
      -- Only close hidden bufs
      non_hidden_bufs[buffer] == nil
      -- that have not being modified
      and not vim.api.nvim_get_option_value('modified', { buf = buffer })
      -- and that are not scratch bufs, since LSP and nvim-tree would stop working.
      -- Scratch buffer is defined here: `:h special-buffers`
      and not (
        vim.api.nvim_get_option_value('buftype', { buf = buffer }) == 'nofile'
        and vim.api.nvim_get_option_value('bufhidden', { buf = buffer }) == 'hide'
      )
    then
      vim.cmd('bwipe ' .. buffer)
    end
  end
end

vim.api.nvim_create_user_command('CloseHiddenBuffers', CloseHiddenBuffers, {})
vim.keymap.set('n', '<Leader>c', CloseHiddenBuffers, { desc = 'Close hidden buffers' })
