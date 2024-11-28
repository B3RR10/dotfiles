return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'http',
        'json',
      })
    end,
  },
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
  },
  {
    'mattn/emmet-vim',
    ft = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'vue' },
  },
}
