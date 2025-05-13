---@type vim.lsp.ClientConfig
return {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm' },
  settings = { yamlls = { path = vim.fn.exepath('yaml-language-server') } },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  root_markers = { 'Chart.yaml' },
}
