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
  -- {
  --   'rest-nvim/rest.nvim',
  --   dependencies = {
  --     'plenary.nvim',
  --     {
  --       'vhyrro/luarocks.nvim',
  --       -- config = true,
  --       opts = {
  --         rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' },
  --       },
  --     },
  --   },
  --   -- cmd = 'Rest',
  --   ft = 'http',
  --   opts = {
  --     skip_ssl_verification = false,
  --     result = {
  --       split = {
  --         horizontal = true,
  --         stay_in_current_window_after_split = true,
  --       },
  --     },
  --     highlight = {
  --       enable = false,
  --       timeout = 150,
  --     },
  --     -- keybinds = {
  --     --   { '<Leader>rr', '<wmd>Rest run<CR>', 'Run request under cursor' },
  --     --   { '<Leader>rl', '<wmd>Rest run last<CR>', 'Re-run last request' },
  --     -- },
  --   },
  --   config = function(_, opts)
  --     require('rest-nvim').setup(opts)
  --   end,
  -- },
  {
    'mattn/emmet-vim',
    ft = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'vue' },
  },
}
