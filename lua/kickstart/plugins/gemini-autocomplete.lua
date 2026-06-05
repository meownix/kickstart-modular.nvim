return {
  'flyingshutter/gemini-autocomplete.nvim',
  opts = function()
    return {
      model = {
        api = require 'gemini-autocomplete.api',
        model_id = require('gemini-autocomplete.api').MODELS.GEMINI_2_5_PRO,
        temperature = 1,
        response_mime_type = 'text/plain',
        get_system_text = function()
          return "You are a coding AI assistant that autocomplete user's code."
            .. '\n* Your task is to provide code suggestion at the cursor location marked by <cursor></cursor>.'
            .. '\n* Your response does not need to contain explaination.'
        end,
      },
      prompt_code = {
        make_prompt = function(buf, pos, user_prompt)
          local context = require 'gemini-autocomplete.context'
          return 'Your task is to write code as prompted by the user. Return only the code. I will give you:\n'
            .. '1) some important files as context\n'
            .. '2) the file we are currently editing, where the cursor position is marked by <cursor></cursor>\n'
            .. '3) the user prompt.\n\n'
            .. '1)\n'
            .. context.make_context_string()
            .. '\n\n'
            .. '2)\n'
            .. context.make_current_file_string(buf, pos)
            .. '\n\n'
            .. '3)\n'
            .. user_prompt
        end,
      },
      completion = {
        enabled = false,
        blacklist_filetypes = { 'help', 'qf', 'yaml', 'toml', 'xml' },
        blacklist_filenames = { '.env' },
        completion_delay = 800,
        insert_result_key = '<C-y>',
        move_cursor_end = true,
        can_autocomplete = function()
          return vim.fn.pumvisible() ~= 1
        end,
        make_prompt = function(buf, pos)
          local context = require 'gemini-autocomplete.context'
          return 'Your task is to write code. Return only the code. I will give you:\n'
            .. '1) some important files as context\n'
            .. '2) the file we are currently editing, where the cursor position is marked by <cursor></cursor>\n'
            .. 'Return the most likely completion at the cursor\n\n'
            .. '1)\n'
            .. context.make_context_string()
            .. '\n\n'
            .. '2)\n'
            .. context.make_current_file_string(buf, pos)
            .. '\n\n'
        end,
      },
    }
  end,
  config = function(_, opts)
    local gemini = require 'gemini-autocomplete'
    gemini.setup(opts)
  end,
  keys = {
    {
      '<leader>Gt',
      function()
        require('gemini-autocomplete').toggle_enabled()
        require('lualine').refresh { place = { 'statusline' }, force = true }
      end,
      desc = 'Toggle autocomplete',
    },
    {
      '<leader>Gg',
      function()
        require('gemini-autocomplete').add_gitfiles()
      end,
      desc = 'Add git files to context',
    },
    {
      '<leader>Ge',
      function()
        require('gemini-autocomplete').edit_context()
      end,
      desc = 'Edit context',
    },
    {
      '<leader>Gp',
      function()
        require('gemini-autocomplete').prompt_code()
      end,
      desc = 'Prompt for code',
    },
    {
      '<leader>Gc',
      function()
        require('gemini-autocomplete').clear_context()
      end,
      desc = 'Clear context',
    },
    {
      '<leader>Gm',
      function()
        require('gemini-autocomplete').choose_model()
      end,
      desc = 'Choose model',
    },
  },
}
