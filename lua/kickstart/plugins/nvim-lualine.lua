return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local gemini_icon = '✦'
    local gemini_disabled_color = '#6c7086'

    local function gemini_autocomplete_status()
      local ok = pcall(require, 'gemini-autocomplete')
      if not ok then
        return ''
      end

      local ok_config, config = pcall(require, 'gemini-autocomplete.config')
      if not ok_config then
        return gemini_icon
      end

      local model_id = config.get_config().model.model_id
      local model_label = model_id:gsub('^gemini%-', '')

      return gemini_icon .. ' ' .. model_label
    end

    local function active_lualine_mode_bg()
      local ok_highlight, highlight = pcall(require, 'lualine.highlight')
      local ok_utils, utils = pcall(require, 'lualine.utils.utils')
      if not ok_highlight or not ok_utils then
        return nil
      end

      return utils.extract_highlight_colors('lualine_a' .. highlight.get_mode_suffix(), 'bg')
    end

    local function gemini_autocomplete_color()
      local ok, gemini = pcall(require, 'gemini-autocomplete')
      if ok and gemini.is_enabled() then
        return { fg = active_lualine_mode_bg() or gemini_disabled_color }
      end

      return { fg = gemini_disabled_color }
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = {
          { gemini_autocomplete_status, color = gemini_autocomplete_color },
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
