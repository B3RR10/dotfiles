if vim.fn.executable('python3') ~= 1 then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'ninja',
        'python',
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'autopep8',
        'flake8',
        'isort',
        'pyright',
        'yapf',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.flake8,
        nls.builtins.formatting.autopep8,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.yapf,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        pyright = {},
      },
    },
  },
}
