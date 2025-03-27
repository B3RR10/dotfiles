return {
  cmd = { 'lua-language-server' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  filetypes = { 'lua' },
  settings = { Lua = {} },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = { version = 'LuaJIT' },
      completion = { callSnippet = 'Replace' },
      diagnostics = { globals = { 'vim' } },
      hint = { enable = true },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath('data') .. '/lazy',
          '${3rd}/luv/library',
        },
        checkThirdParty = false,
      },
    })
  end,
}
