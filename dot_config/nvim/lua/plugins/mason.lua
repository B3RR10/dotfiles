return {
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  cmd = 'Mason',
  opts = {
    ensure_installed = {
      -- ansible
      'ansible-language-server',
      'ansible-lint',

      -- bash/sh
      'bash-language-server',
      'shfmt',
      'shellcheck',

      -- C#
      'roslyn',

      -- docker
      'docker-compose-language-service',
      'dockerfile-language-server',
      'hadolint',

      -- F#
      'fsautocomplete',
      'fantomas',

      -- helm
      'helm-ls',

      -- json
      'json-lsp',

      -- latex
      'texlab',
      'latexindent',

      -- lua
      'lua-language-server',
      'stylua',

      -- markdown
      'markdown-toc',
      'markdownlint',

      -- python
      'python-lsp-server',
      'ruff',

      -- rust
      'rust-analyzer',

      -- terraform
      'terraform-ls',
      'tflint',

      -- toml
      'taplo',

      -- yaml
      'yaml-language-server',
      'yamlfmt',
      'yamllint',
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
