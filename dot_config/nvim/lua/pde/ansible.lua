if not require('config').pde.ansible then
  return {}
end

return {
  {
    'mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'ansible-language-server',
        'ansible-lint',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.ansiblelint,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ansiblels = {},
      },
    },
  },
}
