---@type LazySpec
return {
  'mfussenegger/nvim-lint',
  dependencies = 'mason.nvim',
  event = 'FileType',
  opts = {
    linters_by_ft = {
      ansible = { 'ansible_lint' },
      docker = { 'hadolint' },
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
    lint.linters = opts.linters or {}

    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
