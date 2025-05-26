---@type vim.lsp.ClientConfig
return {
  cmd = { 'gleam', 'lsp' },
  filetypes = { 'gleam' },
  root_markers = { 'gleam.toml', '.git' },
}
