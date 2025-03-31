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

    map(
      ']e',
      function()
        vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR })
      end,
      { desc = 'Jump to the next error in the current buffer' }
    )
    map(
      '[e',
      function()
        vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR })
      end,
      { desc = 'Jump to the previous error in the current buffer' }
    )
    map(
      ']E',
      function()
        vim.diagnostic.jump({
          count = math.huge,
          wrap = false,
          severity = vim.diagnostic.severity.ERROR,
        })
      end,
      { desc = 'Jump to the last error in the current buffer' }
    )
    map(
      '[E',
      function()
        vim.diagnostic.jump({
          count = -math.huge,
          wrap = false,
          severity = vim.diagnostic.severity.ERROR,
        })
      end,
      { desc = 'Jump to the first error in the current buffer' }
    )

    map('grs', Snacks.picker.lsp_symbols, { desc = 'Document Symbols' })
    map('grw', Snacks.picker.lsp_workspace_symbols, { desc = 'Workspace Symbols' })

    -- ----------- --
    -- Inlay hints --
    -- ----------- --
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    -- ------- --
    -- Folding --
    -- ------- --
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    vim.notify_once('Attached to LSP: ' .. client.name, vim.log.levels.INFO, { title = 'LSP' })
  end,
})

-- -------- --
-- Codelens --
-- -------- --
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
  callback = function() vim.lsp.codelens.refresh({ bufnr = 0 }) end,
})
