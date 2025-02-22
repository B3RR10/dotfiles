return {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'BufReadPre',
  dependencies = { 'mason.nvim', 'plenary.nvim' },
  opts = function()
    local nls = require('null-ls')
    return {
      -- root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
      -- sources = {
      --   nls.builtins.code_actions.gomodifytags,
      --   nls.builtins.code_actions.impl,
      --   nls.builtins.diagnostics.ansiblelint,
      --   nls.builtins.diagnostics.hadolint,
      --   nls.builtins.diagnostics.markdownlint,
      --   nls.builtins.diagnostics.ruff,
      --   nls.builtins.diagnostics.shellcheck,
      --   nls.builtins.diagnostics.terraform_validate,
      --   nls.builtins.diagnostics.vint,
      --   nls.builtins.diagnostics.yamllint,
      --   nls.builtins.formatting.black,
      --   nls.builtins.formatting.gofumpt,
      --   nls.builtins.formatting.goimports_reviser,
      --   nls.builtins.formatting.latexindent,
      --   nls.builtins.formatting.markdown_toc,
      --   nls.builtins.formatting.markdownlint,
      --   nls.builtins.formatting.prettier,
      --   nls.builtins.formatting.shfmt,
      --   nls.builtins.formatting.stylua,
      --   nls.builtins.formatting.taplo,
      --   nls.builtins.formatting.terraform_fmt,
      --   nls.builtins.formatting.yamlfmt.with({
      --     extra_args = { '-formatter', 'include_document_start=true,retain_line_breaks=true' },
      --   }),
      -- },
    }
  end,
}
