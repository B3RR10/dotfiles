if not require('config').pde.terraform then
  return {}
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'hcl', 'terraform' },
  desc = 'terraform/hcl commentstring configuration',
  command = 'setlocal commentstring=#\\ %s',
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'terraform',
          'hcl',
        })
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'terraform-ls',
        'tflint',
        'tfsec',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local null_ls = require('null-ls')
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.formatting.terraform_fmt,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        terraformls = {},
        tflint = {},
      },
    },
  },
}
