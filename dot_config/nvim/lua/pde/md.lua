if not require('config').pde.md then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'markdown',
        'markdown_inline',
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
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
      opts.sources = opts.sources or {}
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
