return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'helm',
      })
    end,
  },
  {
    'mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'helm-ls',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        helm_ls = {
          yamlls = {
            path = 'yaml-language-server',
          },
        },
      },
    },
  },
  {
    'towolf/vim-helm',
    ft = 'helm',
  },
}
