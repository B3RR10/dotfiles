local M = {}

local harpoon = require('harpoon')
local icons = require('mini.icons')

---@module 'mini.statusline'

---@return __statusline_section
local is_modified = function()
  if vim.bo.modified then return '●' end
  return ''
end

---@return __statusline_section
local is_harpooned = function()
  local harpoon_icon = icons.get('filetype', 'harpoon')

  local root_dir = harpoon:list().config.get_root_dir()
  local current_file_path = vim.api.nvim_buf_get_name(0)

  local harpoon_items = harpoon:list().items

  for _, harpoon_item in ipairs(harpoon_items) do
    local harpoon_path = harpoon_item.value

    -- If relative path, prepend root_dir
    if string.sub(harpoon_path, 1, 1) ~= '/' then
      local path_separator = '/'
      if vim.fn.has('win32') == 1 or vim.fn.has('win32unix') == 1 then path_separator = '\\' end

      harpoon_path = root_dir .. path_separator .. harpoon_path
    end

    if harpoon_path == current_file_path then return harpoon_icon end
  end

  return ''
end

---@return __statusline_section
local get_filename = function()
  if vim.bo.buftype == 'terminal' then
    return '%t'
  else
    return '%f%m%r'
  end
end

---@return __statusline_section
local get_file_type = function()
  local filetype = vim.bo.filetype
  local icon = icons.get('filetype', filetype)
  if filetype ~= '' then filetype = icon .. ' ' .. filetype end
  return filetype
end

---@param args __statusline_args
---
---@return __statusline_section
local get_encoding = function(args)
  if MiniStatusline.is_truncated(args.trunc_width) then return '' end
  local encoding = vim.bo.fileencoding or vim.bo.encoding
  if vim.bo.bomb then encoding = encoding .. ' [BOM]' end
  return encoding
end

---@param args __statusline_args
---
---@return __statusline_section
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

---@param args __statusline_args
---
---@return __statusline_section
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

---@param args __statusline_args
---
---@return __statusline_section
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
  local harpooned = is_harpooned()

  local git = MiniStatusline.section_git({ trunc_width = 40 })
  local diff = MiniStatusline.section_diff({ icon = '', trunc_width = 75 })
  local diagnostics = MiniStatusline.section_diagnostics({
    wtrunc_width = 75,
    icon = '',
    signs = {
      ERROR = '󰅚 ', -- x000f015a
      WARN = '󰀪 ', -- x000f002a
      INFO = '󰋽 ', -- x000f02fd
      HINT = '󰌶 ', -- x000f0336
    },
  })
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
    { hl = mode_hl, strings = { mode, modified, harpooned } },
    { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
    '%<', -- Mark general truncate point
    { hl = 'MiniStatuslineFilename', strings = { filename } },
    '%=', -- End left alignment
    { hl = 'MiniStatuslineFileinfo', strings = { filetype, encoding, fileformat, filesize } },
    { hl = mode_hl, strings = { search, location } },
  })
end

M.setup = function()
  require('mini.statusline').setup({
    content = {
      active = active_statusline,
    },
  })
end

return M
