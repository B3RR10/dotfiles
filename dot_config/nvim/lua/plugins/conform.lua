---@type LazySpec
return {
  'stevearc/conform.nvim',
  dependencies = 'mason.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  ---@type LazyKeysSpec[]
  keys = {
    {
      'grf',
      function()
        require('conform').format({ async = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      md = { 'markdown-toc' },
      python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
      sh = { 'shfmt' },
      toml = { 'taplo' },
      yaml = { 'yamlfmt' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = { timeout_ms = 500 },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
