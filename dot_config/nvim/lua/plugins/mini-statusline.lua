local icons = require('mini.icons')

local is_modified = function()
  if vim.bo.modified then return '●' end
  return ''
end

local get_git_head = function()
  local branch = vim.fn.FugitiveHead()
  if not branch then return '' end

  local elipsis = #branch > 20
  -- Truncate branch always to 20 chars
  return ' ' .. branch:sub(1, 20) .. (elipsis and '…' or '')
end

local get_filename = function()
  if vim.bo.buftype == 'terminal' then
    return '%t'
  else
    return vim.fn.expand('%:~:.') .. '%m%r'
  end
end

local get_file_type = function()
  local filetype = vim.bo.filetype
  local icon = icons.get('filetype', filetype)
  if filetype ~= '' then filetype = icon .. ' ' .. filetype end
  return filetype
end

local get_encoding = function(args)
  if MiniStatusline.is_truncated(args.trunc_width) then return '' end
  local encoding = vim.bo.fileencoding or vim.bo.encoding
  if vim.bo.bomb then encoding = encoding .. ' [BOM]' end
  return encoding
end

local get_file_format = function(args)
  if MiniStatusline.is_truncated(args.trunc_width) then return '' end
  local get_icon = function(name) return icons.get('os', name) end
  local symbols = {
    unix = get_icon('linux'),
    dos = get_icon('windows'),
    mac = get_icon('macos'),
  }

  local format = vim.bo.fileformat
  return symbols[format]
end

local get_file_size = function(args)
  if MiniStatusline.is_truncated(args.trunc_width) then return '' end

  local file = vim.api.nvim_buf_get_name(0)
  if file == nil or #file == 0 then return '' end

  local size = vim.fn.getfsize(file)
  if size <= 0 then return '' end

  if size < 1024 then
    return string.format('%dB', size)
  elseif size < math.pow(1024, 2) then
    return string.format('%.2fKiB', size / 1024)
  elseif size < math.pow(1024, 3) then
    return string.format('%.2fMiB', size / math.pow(1024, 2))
  else
    return string.format('%.2fGiB', size / math.pow(1024, 3))
  end
end

local get_location = function(args)
  local down_arrow = '↓ '
  local right_arrow = '→'
  if MiniStatusline.is_truncated(args.trunc_width) then
    return down_arrow .. '%l | ' .. right_arrow .. '%2v'
  end
  return down_arrow .. '%l|%L | ' .. right_arrow .. ' %v|%-3{virtcol("$") - 1}'
end

local function active_statusline()
  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  local modified = is_modified()

  local git = get_git_head()
  local diff = MiniStatusline.section_diff({ trunc_width = 75 })
  local diagnostics = MiniStatusline.section_diagnostics({ wtrunc_width = 75 })
  local lsp = MiniStatusline.section_lsp({ icon = icons.get('lsp', 'event'), trunc_width = 75 })

  local filename = get_filename()

  local filetype = get_file_type()
  local encoding = get_encoding({ trunc_width = 120 })
  local fileformat = get_file_format({ trunc_width = 120 })
  local filesize = get_file_size({ trunc_width = 120 })

  local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
  if search ~= '' then search = search .. ' |' end
  local location = get_location({ trunc_width = 85 })

  return MiniStatusline.combine_groups({
    { hl = mode_hl, strings = { mode, modified } },
    { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
    '%<', -- Mark general truncate point
    { hl = 'MiniStatuslineFilename', strings = { filename } },
    '%=', -- End left alignment
    { hl = 'MiniStatuslineFileinfo', strings = { filetype, encoding, fileformat, filesize } },
    { hl = mode_hl, strings = { search, location } },
  })
end

require('mini.statusline').setup({
  content = {
    active = active_statusline,
  },
})
