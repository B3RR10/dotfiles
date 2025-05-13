---@type vim.lsp.ClientConfig
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      format = { enable = true },
      validate = { enable = true },
    },
  },
}
