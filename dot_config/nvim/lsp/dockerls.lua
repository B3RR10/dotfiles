---@type vim.lsp.ClientConfig
return {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile' },
}
