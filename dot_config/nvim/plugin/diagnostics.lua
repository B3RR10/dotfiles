-- Diagnostic configuration
vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
    header = '',
  },
})

-- Hover configuration
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
-- Signature help configuration
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    vim.diagnostic.enable(true, { bufnr = event.buf })
  end
})
