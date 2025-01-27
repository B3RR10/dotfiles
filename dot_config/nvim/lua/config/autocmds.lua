local function augroup(name)
  return vim.api.nvim_create_augroup('nde_' .. name, { clear = true })
end

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
  group = augroup('highlight_yank'),
})

-- Strip trailing spaces and convert tabs to spaces
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    if vim.bo.filetype == 'gitcommit' or vim.wo.diff then
      return
    end
    local currentPos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, currentPos)
    if vim.bo.expandtab then
      vim.cmd('%retab!')
    end
  end,
  group = augroup('FormatBeforeSave'),
})

-- Show relative numbers only in normal mode
local lineNumsGrp = augroup('line_numbers')
vim.api.nvim_create_autocmd('InsertEnter', {
  command = 'set nornu',
  group = lineNumsGrp,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  command = 'set rnu',
  group = lineNumsGrp,
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
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'OverseerForm',
    'OverseerList',
    'checkhealth',
    'floggraph',
    'fugitive',
    'git',
    'help',
    'lspinfo',
    'man',
    'neotest-output',
    'neotest-summary',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'toggleterm',
    'tsplayground',
    'vim',
    'neoai-input',
    'neoai-output',
    'notify',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = augroup('auto_format_options'),
  callback = function()
    vim.cmd('set formatoptions-=cro')
  end,
})
