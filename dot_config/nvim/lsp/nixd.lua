---@type vim.lsp.ClientConfig
return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', '.git' },
  workspace_required = true,
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> { }' },
      formatting = {
        command = { 'nixfmt' },
      },
      options = {
        nix_darwin = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).darwinConfigurations."Acacia".options',
        },
      },
    },
  },
}
