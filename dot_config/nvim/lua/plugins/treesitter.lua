vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    local parsers = require('nvim-treesitter.parsers')
    local lang = parsers.get_buf_lang()
    if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
      vim.notify('Installing TS grammar for: ' .. lang)
      vim.cmd.TSInstall(lang)
    end
  end,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
    },
    build = ':TSUpdate',
    event = { 'BufRead', 'BufNewFile' },
    opts = {
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
        },
        select = {
          enable = true,
          lookahead = false,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['g>'] = '@parameter.inner',
          },
          swap_previous = {
            ['g<'] = '@parameter.inner',
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
