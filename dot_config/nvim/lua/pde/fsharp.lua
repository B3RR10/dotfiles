if not require('config').pde.fsharp then
  return {}
end

return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'fsautocomplete',
        'fantomas',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        fsautocomplete = {
          cmd = { 'fsautocomplete', '--background-service-enabled', '--verbose' },
          root_dir = require('lspconfig.util').root_pattern('*.sln', '.git', '*.fsproj', '*.fsx'),
        },
      },
    },
  },
  {
    'adelarsq/neofsharp.vim',
  },
}
