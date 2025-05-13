local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    bib = { 'tex-fmt' },
    cls = { 'tex-fmt' },
    json = { 'jq' },
    lua = { 'stylua' },
    md = { 'markdown-toc' },
    nix = { 'nixfmt' },
    python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
    sh = { 'shfmt' },
    sty = { 'tex-fmt' },
    tex = { 'tex-fmt' },
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
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set(
  { 'n', 'v' },
  'grf',
  function() conform.format({ async = true }) end,
  { desc = 'Format buffer' }
)
