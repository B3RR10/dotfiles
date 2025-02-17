return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { 'lsp', 'treesitter' },
    },
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
  end,
    -- stylua: ignore
    keys = {
      { '[[', function() require('illuminate').goto_prev_reference() end, desc = 'Prev Reference', },
      { ']]', function() require('illuminate').goto_next_reference() end, desc = 'Next Reference', },
    },
}
