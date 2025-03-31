require('mini.bufremove').setup()

local function CloseBuf(opts) MiniBufremove.wipeout(0, opts.bang) end
vim.api.nvim_create_user_command('Bd', CloseBuf, { bang = true })
