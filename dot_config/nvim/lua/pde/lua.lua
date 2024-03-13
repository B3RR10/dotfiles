return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'lua',
        'luadoc',
        'luap',
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'lua-language-server',
        'stylua',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.stylua,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/neodev.nvim',
        opts = {
          library = { plugins = { 'neotest', 'nvim-dap-ui' }, types = true },
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim' } },
              format = {
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = 2,
                  quote_style = 'single',
                  trailing_table_separator = 'smart',
                  insert_final_newline = true,
                },
              },
              hint = { enable = false },
              runtime = { version = 'LuaJIT' },
              telemetry = { enable = false },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
            },
          },
        },
      },
      setup = {
        lua_ls = function(_, _)
          local lsp_utils = require('base.lsp.utils')
          lsp_utils.on_attach(function(client, buffer)
            -- stylua: ignore start
            if client.name == "lua_ls" then
              vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end,
                { buffer = buffer, desc = "OSV Run" })
              vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end,
                { buffer = buffer, desc = "OSV Launch" })
            end
            -- stylua: ignore end
          end)
        end,
      },
    },
  },
  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'jbyuki/one-small-step-for-vimkind' },
    },
    opts = {
      setup = {
        osv = function(_, _)
          local dap = require('dap')
          dap.configurations.lua = {
            {
              type = 'nlua',
              request = 'attach',
              name = 'Attach to running Neovim instance',
              host = function()
                local value = vim.fn.input('Host [127.0.0.1]: ')
                if value ~= '' then
                  return value
                end
                return '127.0.0.1'
              end,
              port = function()
                local val = tonumber(vim.fn.input('Port: ', '8086'))
                assert(val, 'Please provide a port number')
                return val
              end,
            },
          }

          dap.adapters.nlua = function(callback, config)
            callback({ type = 'server', host = config.host, port = config.port })
          end
        end,
      },
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-plenary',
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require('neotest-plenary'),
      })
    end,
  },
}
