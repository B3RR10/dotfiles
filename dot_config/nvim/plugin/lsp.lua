---@type table<string, vim.lsp.ClientConfig>
local servers = {
  ansiblels = require('lsp.ansiblels'),
  bashls = require('lsp.bashls'),
  docker_compose_language_service = require('lsp.docker_compose_language_service'),
  dockerls = require('lsp.dockerls'),
  helm_ls = require('lsp.helm_ls'),
  lua_ls = require('lsp.lua_ls'),
  pylsp = require('lsp.pylsp'),
  terraformls = require('lsp.terraformls'),
  tflint = require('lsp.tflint'),
  texlab = require('lsp.texlab'),
  jsonls = require('lsp.jsonls'),
  yamlls = require('lsp.yamlls'),
}

local group = vim.api.nvim_create_augroup('user.lsp.start', {})
for name, config in pairs(servers) do
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = config.filetypes,
    callback = function(event)
      config.name = name
      if config.root_markers then
        config.root_dir = vim.fs.root(event.buf, config.root_markers)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      config.capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        config.capabilities or {},
        require('cmp_nvim_lsp').default_capabilities()
      )

      vim.lsp.start(config, {
        bufnr = event.buf,
        reuse_client = function(client, client_config)
          return client.name == name and client_config.root_dir == config.root_dir
        end,
      })
    end,
  })
end
