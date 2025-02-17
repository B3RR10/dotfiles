if vim.fn.executable('docker') ~= 1 then
  return {}
end

return {
  {
    'mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'hadolint',
        'docker-compose-language-service',
        'dockerfile-language-server',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.hadolint,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },
}
