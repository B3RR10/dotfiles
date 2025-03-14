---@type table<string, vim.lsp.ClientConfig>
local servers = {
  ansiblels = require('lsp.ansiblels'),
  bashls = require('lsp.bashls'),
  docker_compose_language_service = require('lsp.docker_compose_language_service'),
  dockerls = require('lsp.dockerls'),
  helm_ls = require('lsp.helm_ls'),
  lua_ls = require('lsp.lua_ls'),
  pylsp = require('lsp.pylsp'),
  terraformls = require('lsp.terraformls'),
  tflint = require('lsp.tflint'),
  texlab = require('lsp.texlab'),
  jsonls = require('lsp.jsonls'),
  yamlls = require('lsp.yamlls'),
}

local group = vim.api.nvim_create_augroup('user.lsp.start', {})
for name, config in pairs(servers) do
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = config.filetypes,
    callback = function(event)
      config.name = name
      if config.root_markers then config.root_dir = vim.fs.root(event.buf, config.root_markers) end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      config.capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        config.capabilities or {},
        require('cmp_nvim_lsp').default_capabilities()
      )

      vim.lsp.start(config, {
        bufnr = event.buf,
        reuse_client = function(client, client_config)
          return client.name == name and client_config.root_dir == config.root_dir
        end,
      })
    end,
  })
end

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
