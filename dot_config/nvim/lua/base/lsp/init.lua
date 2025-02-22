return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'b0o/SchemaStore.nvim',
      'williamboman/mason.nvim',
    },
    opts = {
      servers = {},
      setup = {},
      format = {
        timeout_ms = 3000,
      },
    },
    config = function(plugin, opts)
      require('base.lsp.servers').setup(plugin, opts)
    end,
  },
}
