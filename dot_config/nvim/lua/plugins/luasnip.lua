return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'honza/vim-snippets',
    'rafamadriz/friendly-snippets',
  },
  build = 'make install_jsregexp',
  opts = {
    history = true,
    delete_check_events = 'TextChanged',
  },
  keys = {
    {
      '<C-j>',
      function() return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<C-j>' end,
      expr = true,
      remap = true,
      silent = true,
      mode = 'i',
    },
    {
      '<C-j>',
      function() require('luasnip').jump(1) end,
      mode = 's',
    },
    {
      '<C-k>',
      function() require('luasnip').jump(-1) end,
      mode = { 'i', 's' },
    },
  },
  config = function(_, opts)
    require('luasnip').setup(opts)
    require('luasnip.loaders.from_snipmate').lazy_load()
    require('luasnip.loaders.from_snipmate').lazy_load({ paths = { './snippets' } })
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}
