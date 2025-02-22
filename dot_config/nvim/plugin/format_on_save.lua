local fmt_group = vim.api.nvim_create_augroup('user.autofmt', { clear = true })

local function setup_autoformat(event)
  local id = event.data.client_id
  local client = id and vim.lsp.get_client_by_id(id)
  if client == nil or not client.supports_method('textDocument/formatting') then
    return
  end

  vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = event.buf })

  local buf_format = function(e)
    vim.notify('Formatting: ' .. client.name, "info")

    vim.lsp.buf.format({
      bufnr = e.buf,
      async = false,
      timeout_ms = 10000,
    })

    vim.diagnostic.enable(e.buf)
  end

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = event.buf,
    group = fmt_group,
    desc = 'Format current buffer',
    callback = buf_format,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Setup format on save',
  callback = setup_autoformat,
})
