return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'css',
        'jq',
        'json',
        'json5',
        'jsonc',
        'html',
        'scss',
        'yaml',
      })
    end,
  },
  {
    'mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'css-lsp',
        'html-lsp',
        'json-lsp',
        'prettier',
        'tailwindcss-language-server',
        'typescript-language-server',
        'yaml-language-server',
        'yamlfmt',
        'yamllint',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.prettier,
        nls.builtins.formatting.yamlfmt.with({
          extra_args = { '-formatter', 'include_document_start=true,retain_line_breaks=true' },
        }),
        nls.builtins.diagnostics.yamllint,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        cssls = {},
        html = {},
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
        tailwindcss = {},
        ts_ls = {},
        yamlls = {
          settings = {
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      },
    },
  },
}
