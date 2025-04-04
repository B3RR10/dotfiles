local group = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function() vim.highlight.on_yank({ timeout = 300 }) end,
  group = group,
})

-- Strip trailing spaces and convert tabs to spaces
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    if vim.bo.filetype == 'gitcommit' or vim.wo.diff then return end
    local currentPos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, currentPos)
    if vim.bo.expandtab then vim.cmd('%retab!') end
  end,
  group = group,
})

-- Show relative numbers only in normal mode
vim.api.nvim_create_autocmd('InsertEnter', {
  command = 'set nornu',
  group = group,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  command = 'set rnu',
  group = group,
})

-- Allow comments in json
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'json',
  command = [[syntax match Comment +\/\/.\+$+]],
})

-- Disable fold in commit buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  command = 'set nofoldenable',
})

-- windows to close
local function close(opts)
  vim.bo[opts.buffer].buflisted = false
  return pcall(vim.cmd.close) or pcall(vim.cmd.quit)
end

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = {
    'checkhealth',
    'fugitive',
    'git',
    'help',
    'lspinfo',
    'man',
    'minideps-confirm',
    'qf',
    'query',
    'startuptime',
    'tsplayground',
    'vim',
    'notify',
  },
  callback = function(event)
    vim.keymap.set(
      'n',
      'q',
      function() close({ buffer = event.buf }) end,
      { buffer = event.buf, silent = true }
    )
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = group,
  callback = function() vim.cmd('set formatoptions-=cro') end,
})
