local lint = require('lint')

lint.linters_by_ft = {
  ansible = { 'ansible_lint' },
  dockerfile = { 'hadolint' },
  markdown = { 'markdownlint' },
  python = { 'ruff' },
  sh = { 'shellcheck' },
  terraform = { 'tflint' },
  yaml = { 'yamllint' },
}

local group = vim.api.nvim_create_augroup('nvim-lint', { clear = true })
vim.api.nvim_create_autocmd({
  'BufReadPost',
  'BufWritePost',
  'InsertLeave',
  'TextChanged',
}, {
  group = group,
  callback = function() lint.try_lint() end,
})
