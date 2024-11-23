if vim.fn.executable('dotnet') ~= 1 then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'fsharp' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'fsautocomplete',
        'fantomas',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        fsautocomplete = {
          mason = false,
          ignore = true,
        },
      },
    },
  },
  {
    'ionide/Ionide-vim',
    ft = { 'fsharp' },
  },
  {
    'adelarsq/neofsharp.vim',
    ft = { 'fsharp' },
  },
}
