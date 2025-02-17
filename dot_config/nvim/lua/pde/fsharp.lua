if vim.fn.executable('dotnet') ~= 1 then
  return {}
end

return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'fsautocomplete',
        'fantomas',
      })
    end,
  },
  {
    'ionide/Ionide-vim',
    ft = { 'fsharp' },
    config = function()
      require('ionide').setup({
        autostart = true,
        on_attach = function(client, bufnr)
          require('base.lsp.format').on_attach(client, bufnr)
          require('base.lsp.keymaps').on_attach(client, bufnr)
        end,
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = require('base.lsp.utils').capabilities(),
      })
    end,
  },
  {
    'adelarsq/neofsharp.vim',
    ft = { 'fsharp' },
  },
}
