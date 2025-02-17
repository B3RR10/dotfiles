local M = {}

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)

  -- stylua: ignore start
  self:map('gd', Snacks.picker.lsp_definitions,      { desc = 'Goto Definition' })
  self:map('gr', Snacks.picker.lsp_references,       { desc = 'References' })
  self:map('gI', Snacks.picker.lsp_implementations,  { desc = 'Goto Implementation' })
  self:map('gy', Snacks.picker.lsp_type_definitions, { desc = 'Goto Type Definition' })

  self:map('K',  vim.lsp.buf.hover,          { desc = 'Hover' })
  self:map('gK', vim.lsp.buf.signature_help, { desc = 'Signature Help', has = 'signatureHelp' })

  self:map('<leader>ld', Snacks.picker.diagnostics_buffer, { desc = 'Buffer diagnostics' })
  self:map('<leader>lD', Snacks.picker.diagnostics,        { desc = 'Diagnostics' })

  self:map('[e', function() MiniBracketed.diagnostic('backward', { severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Prev Error' })
  self:map(']e', function() MiniBracketed.diagnostic('forward',  { severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Next Error' })

  self:map('<leader>la', vim.lsp.buf.code_action, { desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' })

  local format = require('base.lsp.format').format
  self:map('<leader>lf', format,             { desc = 'Format Document', has = 'documentFormatting' })
  self:map('<leader>lf', format,             { desc = 'Format Range',    mode = 'v',      has = 'documentRangeFormatting' })
  self:map('<leader>lr', vim.lsp.buf.rename, { expr = true,              desc = 'Rename', has = 'rename' })

  self:map('<leader>ls', Snacks.picker.lsp_symbols,           { desc = 'Document Symbols' })
  self:map('<leader>lS', Snacks.picker.lsp_workspace_symbols, { desc = 'Workspace Symbols' })
  -- stylua: ignore end
end

function M.new(client, buffer)
  return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
  return self.client.server_capabilities[cap .. 'Provider']
end

function M:map(lhs, rhs, opts)
  opts = opts or {}
  if opts.has and not self:has(opts.has) then
    return
  end
  vim.keymap.set(
    opts.mode or 'n',
    lhs,
    type(rhs) == 'string' and ('<cmd>%s<cr>'):format(rhs) or rhs,
    ---@diagnostic disable-next-line: no-unknown
    { silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
  )
end

return M
