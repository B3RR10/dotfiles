if vim.fn.executable('ansible') ~= 1 then
  return {}
end

return {
  {
    'mason.nvim',
    opts = function(_, opts)
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
  {
    'mfussenegger/nvim-ansible',
    ft = { 'yaml.ansible', 'yaml' },
  },
}
