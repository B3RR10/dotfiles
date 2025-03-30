local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities =
  vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

require('ionide').setup({
  autostart = true,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
})
