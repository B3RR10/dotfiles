---@type LazySpec
return {
  'mfussenegger/nvim-lint',
  dependencies = 'mason.nvim',
  lazy = false,
  opts = {
    events = {
      'BufReadPost',
      'BufWritePost',
      'InsertLeave',
      'TextChanged',
    },
    linters_by_ft = {
      ansible = { 'ansible_lint' },
      dockerfile = { 'hadolint' },
      markdown = { 'markdownlint' },
      python = { 'ruff' },
      sh = { 'shellcheck' },
      terraform = { 'tflint' },
      yaml = { 'yamllint' },
    },
  },
  config = function(_, opts)
    local lint = require('lint')

    lint.linters_by_ft = opts.linters_by_ft or {}

    local group = vim.api.nvim_create_augroup('nvim-lint', { clear = true })
    vim.api.nvim_create_autocmd(opts.events, {
      group = group,
      callback = function() lint.try_lint() end,
    })
  end,
}
