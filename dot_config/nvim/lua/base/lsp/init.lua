return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      defaults = {
        ['<leader>l'] = { name = '+Language' },
      },
    },
  },
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
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
      ensure_installed = {},
      registries = {
        'github:mason-org/mason-registry',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'mason.nvim' },
    opts = function()
      return {
        root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
        sources = {},
      }
    end,
  },
}
