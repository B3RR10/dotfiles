local capabilities = require('blink.cmp').get_lsp_capabilities()

require('ionide').setup({
  autostart = true,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
})
