require('mini.pick').setup({
  mappings = {
    choose_marked = '<C-q>',
  },
})

vim.ui.select = MiniPick.ui_select

local is_git_repo = function()
  vim.fn.system('git rev-parse --is-inside-work-tree')
  return vim.v.shell_error == 0
end

local get_git_root = function()
  local dot_git_path = vim.fn.finddir('.git', '.;')
  return vim.fn.fnamemodify(dot_git_path, ':h')
end

local get_path_opts = function()
  return is_git_repo() and { source = { cwd = get_git_root() } } or {}
end

vim.keymap.set('n', '<leader><leader>', MiniPick.builtin.resume, { desc = 'Resume last picker' })
vim.keymap.set('n', '<leader><space>', MiniPick.builtin.buffers, { desc = 'Find Buffers' })
vim.keymap.set(
  'n',
  '<leader>l',
  function() MiniExtra.pickers.visit_paths({}, get_path_opts()) end,
  { desc = 'List visit paths' }
)

vim.keymap.set('n', '<leader>ff', function()
  if is_git_repo() then
    MiniExtra.pickers.git_files({}, get_path_opts())
  else
    MiniPick.builtin.cli({ command = { 'fd', '--hidden', '--type', 'f' } }, get_path_opts())
  end
end, { desc = 'Find files (Git root or CWD)' })
vim.keymap.set(
  'n',
  '<leader>fF',
  function()
    MiniPick.builtin.cli(
      { command = { 'fd', '--hidden', '--no-ignore', '--follow', '--type', 'f' } },
      get_path_opts()
    )
  end,
  { desc = 'Find files in ~' }
)
vim.keymap.set(
  'n',
  '<leader>fr',
  function() MiniPick.builtin.grep_live({}, get_path_opts()) end,
  { desc = 'Grep' }
)
vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help, { desc = 'Help pages' })
