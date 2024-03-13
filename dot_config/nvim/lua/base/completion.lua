return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'ray-x/cmp-treesitter',
      'onsails/lspkind-nvim',
      { 'zbirenbaum/copilot-cmp', config = true },
    },
    opts = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local luasnip = require('luasnip')
      local compare = require('cmp.config.compare')
      local source_names = {
        copilot = '[Copilot]',
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
        sorting = {
          priority_weight = 2,
          comparators = {
            compare.score,
            compare.recently_used,
            compare.offset,
            compare.exact,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
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
              -- elseif cmp.visible() then
              --   cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
              -- elseif cmp.visible() then
              --   cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = 'copilot', group_index = 1 },
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'luasnip', group_index = 1 },
          { name = 'buffer', group_index = 2, option = { keyword_pattern = [[\k\+]] } },
          { name = 'path', group_index = 2 },
          { name = 'treesitter', group_index = 2 },
        }),
        formatting = {
          format = lspkind.cmp_format({
            menu = source_names,
            mode = 'symbol',
            symbol_map = { Copilot = '' },
          }),
        },
        experimental = {
          hl_group = 'LspCodeLens',
          ghost_text = {},
        },
        window = {
          documentation = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
          },
        },
      }
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
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
        function()
          return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<C-j>'
        end,
        expr = true,
        remap = true,
        silent = true,
        mode = 'i',
      },
      {
        '<C-j>',
        function()
          require('luasnip').jump(1)
        end,
        mode = 's',
      },
      {
        '<C-k>',
        function()
          require('luasnip').jump(-1)
        end,
        mode = { 'i', 's' },
      },
    },
    config = function(_, opts)
      require('luasnip').setup(opts)
      require('luasnip.loaders.from_snipmate').lazy_load()
      require('luasnip.loaders.from_snipmate').lazy_load({ paths = { './snippets' } })
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
