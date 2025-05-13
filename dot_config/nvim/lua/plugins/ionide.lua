vim.g['fsharp#lsp_auto_setup'] = 0
vim.g['fsharp#exclude_project_directories'] = { 'paket-files' }

require('ionide').setup({
  autostart = true,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
