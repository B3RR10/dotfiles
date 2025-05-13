---@type vim.lsp.ClientConfig
return {
  cmd = { 'tflint', '--langserver' },
  filetypes = { 'terraform' },
  root_markers = { '.terraform', '.git', '.tflint.hcl' },
}
