local M = {}

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)

  local fzf = require('fzf-lua')

  self:map('gd', fzf.lsp_definitions, { desc = 'Goto Definition' })
  self:map('gD', fzf.lsp_declarations, { desc = 'Goto Declaration' })
  self:map('gr', fzf.lsp_references, { desc = 'References' })
  self:map('gI', fzf.lsp_implementations, { desc = 'Goto Implementation' })
  self:map('gy', fzf.lsp_typedefs, { desc = 'Goto Type Definition' })

  self:map('K', vim.lsp.buf.hover, { desc = 'Hover' })
  self:map('gK', vim.lsp.buf.signature_help, { desc = 'Signature Help', has = 'signatureHelp' })

  self:map('<leader>ld', fzf.lsp_document_diagnostics, { desc = 'Show document diagnostics' })
  self:map('<leader>lD', fzf.lsp_workspace_diagnostics, { desc = 'Show workspace diagnostics' })
  self:map('[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic' })
  self:map(']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })

  self:map('<leader>la', fzf.lsp_code_actions, { desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' })

  local format = require('base.lsp.format').format
  self:map('<leader>lf', format, { desc = 'Format Document', has = 'documentFormatting' })
  self:map('<leader>lf', format, { desc = 'Format Range', mode = 'v', has = 'documentRangeFormatting' })
  self:map('<leader>lr', vim.lsp.buf.rename, { expr = true, desc = 'Rename', has = 'rename' })

  self:map('<leader>ls', fzf.lsp_document_symbols, { desc = 'Document Symbols' })
  self:map('<leader>lS', fzf.lsp_workspace_symbols, { desc = 'Workspace Symbols' })
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
