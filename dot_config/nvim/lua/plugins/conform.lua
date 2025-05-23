local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    bib = { 'tex-fmt' },
    cls = { 'tex-fmt' },
    fsharp_project = { 'xmllint' },
    json = { 'jq' },
    lua = { 'stylua' },
    md = { 'markdown-toc' },
    nix = { 'nixfmt' },
    python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
    sh = { 'shfmt' },
    sty = { 'tex-fmt' },
    tex = { 'tex-fmt' },
    toml = { 'taplo' },
    xml = { 'xmllint' },
    yaml = { 'yamlfmt' },
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return {
      timeout_ms = 500,
    }
  end,
  formatters = {
    shfmt = {
      prepend_args = { '-i', '2' },
    },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- Disable autoformat for this buffer only
    vim.b.disable_autoformat = true
    vim.notify('Disabled autoformat for current buffer')
  else
    -- Disable autoformat globally
    vim.g.disable_autoformat = true
    vim.notify('Disabled autoformat globally', vim.log.levels.WARN)
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
  vim.notify('Enabled autoformat')
end, {
  desc = 'Enable autoformat-on-save',
})

vim.keymap.set(
  { 'n', 'v' },
  'grf',
  function() conform.format({ async = true }) end,
  { desc = 'Format buffer' }
)

vim.keymap.set('n', '<leader>tf', function()
  if vim.b.disable_autoformat then
    vim.cmd.FormatEnable()
  else
    vim.cmd.FormatDisable({ bang = true })
  end
end, { desc = 'Toggle autoformat for current buffer' })

vim.keymap.set('n', '<leader>tF', function()
  if vim.b.disable_autoformat then
    vim.cmd.FormatEnable()
  else
    vim.cmd.FormatDisable()
  end
end, { desc = 'Toggle autoformat for current buffer' })
