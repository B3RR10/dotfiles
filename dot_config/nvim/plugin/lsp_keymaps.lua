---@diagnostic disable: need-check-nil
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Keymaps',
  callback = function(event)
    local map = function(lhs, rhs, opts)
      opts = opts or {}
      -- stylua: ignore
      vim.keymap.set(opts.mode or 'n', lhs, rhs, { silent = true, buffer = event.buf, desc = opts.desc })
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    map('gd', Snacks.picker.lsp_definitions, { desc = 'Goto Definition' })
    map('grr', Snacks.picker.lsp_references, { desc = 'References' })
    map('gri', Snacks.picker.lsp_implementations, { desc = 'Goto Implementation' })
    map('grt', Snacks.picker.lsp_type_definitions, { desc = 'Goto Type Definition' })

    map('<C-s>', vim.lsp.buf.signature_help, { desc = 'Signature Help', mode = 'i' })

    -- stylua: ignore start
    map('[e', function() MiniBracketed.diagnostic('backward', { severity = vim.diagnostic.severity.ERROR }) end,
      { desc = 'Prev Error' })
    map(']e', function() MiniBracketed.diagnostic('forward', { severity = vim.diagnostic.severity.ERROR }) end,
      { desc = 'Next Error' })
    -- stylua: ignore end

    if client.supports_method('textDocument/codeAction') then
      map('gra', vim.lsp.buf.code_action, { desc = 'Code Action', mode = { 'n', 'v' } })
    end

    if client.supports_method('textDocument/rename') then
      map('grn', vim.lsp.buf.rename, { desc = 'Rename' })
    end

    map('grs', Snacks.picker.lsp_symbols, { desc = 'Document Symbols' })
    map('grw', Snacks.picker.lsp_workspace_symbols, { desc = 'Workspace Symbols' })

    vim.notify_once('Starting LSP:' .. client.name, 'info', { title = 'LSP' })
  end,
})
