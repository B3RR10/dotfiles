---@diagnostic disable: undefined-field

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-path',
    'ray-x/cmp-treesitter',
    'onsails/lspkind-nvim',
  },
  opts = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    local source_names = {
      buffer = '[Buffer]',
      luasnip = '[Snippet]',
      nvim_lsp = '[LSP]',
      path = '[Path]',
      treesitter = '[Treesitter]',
    }

    return {
      completion = {
        completeopt = 'menu,menuone,noselect',
      },
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),

        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer', option = { keyword_pattern = [[\k\+]] } },
        { name = 'path' },
        { name = 'treesitter' },
      }),
      formatting = {
        format = lspkind.cmp_format({
          menu = source_names,
          mode = 'symbol',
        }),
      },
      experimental = {
        ghost_text = false,
      },
      window = {
        documentation = {
          border = 'rounded',
          winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
        },
      },
    }
  end,
}
