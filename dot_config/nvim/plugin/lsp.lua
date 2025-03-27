vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
})

vim.lsp.enable({
  'ansiblels',
  'bashls',
  'docker_compose_language_service',
  'dockerls',
  'helm_ls',
  'lua_ls',
  'pylsp',
  'terraformls',
  'tflint',
  'texlab',
  'jsonls',
  'yamlls',
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Setup',
  callback = function(event)
    local map = function(lhs, rhs, opts)
      opts = opts or {}
      vim.keymap.set(
        opts.mode or 'n',
        lhs,
        rhs,
        { silent = true, buffer = event.buf, desc = opts.desc }
      )
    end

    local id = event.data.client_id
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then return end

    -- -------- --
    -- Mappings --
    -- -------- --

    map('gd', Snacks.picker.lsp_definitions, { desc = 'Goto Definition' })
    map('grr', Snacks.picker.lsp_references, { desc = 'References' })
    map('gri', Snacks.picker.lsp_implementations, { desc = 'Goto Implementation' })
    map('grt', Snacks.picker.lsp_type_definitions, { desc = 'Goto Type Definition' })

    map('<C-s>', vim.lsp.buf.signature_help, { desc = 'Signature Help', mode = 'i' })

    map(
      '[e',
      function() MiniBracketed.diagnostic('backward', { severity = vim.diagnostic.severity.ERROR }) end,
      { desc = 'Prev Error' }
    )
    map(
      ']e',
      function() MiniBracketed.diagnostic('forward', { severity = vim.diagnostic.severity.ERROR }) end,
      { desc = 'Next Error' }
    )

    map('grs', Snacks.picker.lsp_symbols, { desc = 'Document Symbols' })
    map('grw', Snacks.picker.lsp_workspace_symbols, { desc = 'Workspace Symbols' })

    if client.supports_method('textDocument/codeAction') then
      map('gra', vim.lsp.buf.code_action, { desc = 'Code Action', mode = { 'n', 'v' } })
    end

    if client.supports_method('textDocument/rename') then
      map('grn', vim.lsp.buf.rename, { desc = 'Rename' })
    end

    -- ----------- --
    -- Inlay hints --
    -- ----------- --

    if client.supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    vim.notify_once('Starting LSP: ' .. client.name, vim.log.levels.INFO, { title = 'LSP' })
  end,
})

-- -------- --
-- Codelens --
-- -------- --
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
  callback = function() vim.lsp.codelens.refresh({ bufnr = 0 }) end,
})
