return {
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  cmd = 'Mason',
  opts = {
    -- TODO: Define what should stay and what should go. Enable in null-ls the ones staying
    ensure_installed = {
      -- LSP
      'ansible-language-server',
      'bash-language-server',
      'css-lsp',
      'docker-compose-language-service',
      'dockerfile-language-server',
      'fsautocomplete',
      'helm-ls',
      'html-lsp',
      'json-lsp',
      'lua-language-server',
      'python-lsp-server',
      'roslyn',
      'rust-analyzer',
      'tailwindcss-language-server',
      'terraform-ls',
      'texlab',
      'tflint',
      'typescript-language-server',
      'vim-language-server',
      'yaml-language-server',
      'yamllint',

      -- Debbuger
      'codelldb',

      -- Linter
      'ansible-lint',
      'hadolint',
      'markdownlint',
      'shellcheck',

      -- Formater
      'fantomas',
      'latexindent',
      'prettier',
      'shfmt',
      'stylua',
      'yamlfmt',

      -- NPI
      'black',
      'delve',
      'iferr',
      'impl',
      'markdown-toc',
      'ruff',
      'taplo',
      'tfsec',
      'vint',
    },
    registries = {
      'github:mason-org/mason-registry',
      'github:Crashdummyy/mason-registry',
    },
  },
  config = function(_, opts)
    require('mason').setup(opts)
    local mr = require('mason-registry')
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
