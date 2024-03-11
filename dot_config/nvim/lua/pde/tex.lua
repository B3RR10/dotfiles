if not require('config').pde.tex then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'bibtex',
        'latex',
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'texlab',
        'latexindent',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.latexindent
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                args = {
                  '-pdf',
                  '-interaction=nonstopmode',
                  '-output-directory=build',
                  '-synctex=1',
                  '-shell-escape',
                  '%f',
                },
                executable = 'latexmk',
                onSave = true,
              },
              chktex = {
                onOpenAndSave = true,
              },
            },
          },
        },
      },
    },
  },
}
