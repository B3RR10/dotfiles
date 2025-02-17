return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'markdownlint',
        'markdown-toc',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.formatting.markdownlint,
        nls.builtins.formatting.markdown_toc,
      })
    end,
  },
  {
    'ellisonleao/glow.nvim',
    config = true,
    cmd = 'Glow',
  },
}
