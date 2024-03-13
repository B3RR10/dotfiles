return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'http',
          'json',
        })
      end
    end,
  },
  {
    'rest-nvim/rest.nvim',
    dependencies = { 'plenary.nvim' },
    ft = 'http',
    opts = {
      result_split_horizontal = true,
      skip_ssl_verification = false,
      highlight = {
        enabled = false,
        timeout = 150,
      },
      jump_to_request = false,
    },
    config = function(opts)
      require('rest-nvim').setup(opts)

      vim.keymap.set('n', '<Leader>x', '<Plug>RestNvim', { desc = 'Execute request' })
    end,
  },
  {
    'mattn/emmet-vim',
    ft = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'vue' },
  },
}
