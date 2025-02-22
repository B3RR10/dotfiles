vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Enable inlay hints',
  callback = function(event)
    local id = event.data.client_id
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil or not client.supports_method('textDocument/inlayHint') then
      return
    end

    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
  end
})
