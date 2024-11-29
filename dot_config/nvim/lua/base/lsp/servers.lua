local M = {}

local lsp_utils = require('base.lsp.utils')

local function lsp_init()
  -- LSP handlers configuration
  local config = {
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
    },

    diagnostic = {
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    },
  }

  -- Diagnostic configuration
  vim.diagnostic.config(config.diagnostic)

  -- Hover configuration
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

  -- Signature help configuration
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

local function setup(server, opts, setup)
  local on_attach = function(client, bufnr)
    require('base.lsp.format').on_attach(client, bufnr)
    require('base.lsp.keymaps').on_attach(client, bufnr)
    if opts['on_attach'] then
      opts.on_attach(client, bufnr)
    end
    vim.notify_once('Attached to LSP server: ' .. server, vim.log.levels.INFO)
  end
  local client_opts = vim.tbl_deep_extend('keep', {
    capabilities = lsp_utils.capabilities(),
    on_attach = on_attach,
  }, opts or {})

  if setup then
    pcall(setup, opts)
  end

  require('lspconfig')[server].setup(client_opts)
end

function M.setup(_, opts)
  lsp_init() -- diagnostics, handlers

  for server, server_opts in pairs(opts.servers) do
    setup(server, server_opts, opts.setup[server] or nil)
  end
end

return M
