local M = {}

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)

  local telescope = require('telescope.builtin')

  -- stylua: ignore
  self:map('gd', function() telescope.lsp_definitions({ reuse_win = true }) end, { desc = 'Goto Definition' })
  self:map('gr', telescope.lsp_references, { desc = 'References' })
  -- stylua: ignore
  self:map('gI', function() telescope.lsp_implementations({ reuse_win = true }) end, { desc = 'Goto Implementation' })
  -- stylua: ignore
  self:map('gy', function() telescope.lsp_type_definitions({ reuse_win = true }) end, { desc = 'Goto Type Definition' })

  self:map('K', vim.lsp.buf.hover, { desc = 'Hover' })
  self:map('gK', vim.lsp.buf.signature_help, { desc = 'Signature Help', has = 'signatureHelp' })

  -- stylua: ignore
  self:map('<leader>ld', function() telescope.diagnostics({ bufnr = 0 }) end, { desc = 'Show document diagnostics' })
  self:map('<leader>lD', telescope.diagnostics, { desc = 'Show workspace diagnostics' })
  self:map('[d', M.diagnostic_goto(false), { desc = 'Prev Diagnostic' })
  self:map(']d', M.diagnostic_goto(true), { desc = 'Next Diagnostic' })
  self:map('[e', M.diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
  self:map(']e', M.diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
  self:map('[w', M.diagnostic_goto(false, 'WARNING'), { desc = 'Prev Warning' })
  self:map(']w', M.diagnostic_goto(true, 'WARNING'), { desc = 'Next Warning' })

  self:map('<leader>la', vim.lsp.buf.code_action, { desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' })

  local format = require('base.lsp.format').format
  self:map('<leader>lf', format, { desc = 'Format Document', has = 'documentFormatting' })
  self:map('<leader>lf', format, { desc = 'Format Range', mode = 'v', has = 'documentRangeFormatting' })
  self:map('<leader>lr', vim.lsp.buf.rename, { expr = true, desc = 'Rename', has = 'rename' })

  self:map('<leader>ls', telescope.lsp_document_symbols, { desc = 'Document Symbols' })
  self:map('<leader>lS', telescope.lsp_dynamic_workspace_symbols, { desc = 'Workspace Symbols' })
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

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
