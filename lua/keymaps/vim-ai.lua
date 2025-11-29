vim.keymap.set('n', '<leader>a', ':AI<CR>')
vim.keymap.set('v', '<leader>a', ':AI<CR>')

vim.keymap.set('v', '<leader>cs', ':AIEdit fix grammar and spelling<CR>')
vim.keymap.set('n', '<leader>cs', ':AIEdit fix grammar and spelling<CR>')
vim.keymap.set('v', '<leader>cS', ':AIEdit make it shorter<CR>')
vim.keymap.set('n', '<leader>cS', ':AIEdit make it shorter<CR>')
vim.keymap.set('v', '<leader>cn', ':AIEdit make it sounds more natural<CR>')
vim.keymap.set('v', '<leader>cipa', ':AIEdit convert this into theirs International Phonetic Alphabet which include theirs stress symbols<CR>')
vim.keymap.set('v', '<leader>cpin', ':AIEdit convert to pinyin with tones<CR>')
vim.keymap.set('v', '<leader>ci', ':AIEdit translates into Indonesian in a natural way<CR>')
vim.keymap.set('v', '<leader>ce', ':AIEdit translates into natural English<CR>')
vim.keymap.set('v', '<leader>cc', ':AIEdit translates into natural Chinese<CR>')
vim.keymap.set('n', '<leader>def', ':call AIDictFn()<CR>')
vim.keymap.set('v', '<leader>ys', ':AICDict<CR>')

vim.keymap.set('v', '<leader>c', ':AIChat<CR>')
vim.keymap.set('n', '<leader>c', ':AIChat<CR>')

vim.keymap.set('n', '<leader>gc', ':GitCommitMessage<CR>')

-- I have no idea how to make this one works. It seems to work with AIEdit, but
-- not with the AIChat.
--[[
function LoadAIToken()
  local handle = io.popen 'vim-ai.token.zsh'

  if not handle then
    print 'Error: Failed to execute shell command'
    return nil
  end

  local api_key = handle:read '*a'
  api_key = tostring(api_key:gsub('\n', ''))

  handle:close()

  return api_key
end

-- Global variables
vim.g.vim_ai_token_load_fn = "luaeval('LoadAIToken()')"
--]]

vim.g.vim_ai_chat_markdown = 1

local chat_engine_config = {
  engine = 'chat',
  options = {
    model = 'deepseek-chat',
    endpoint_url = 'https://api.deepseek.com/chat/completions',
    request_timeout = 20,
    stream = 1,
  },
}

vim.g.vim_ai_chat = chat_engine_config
vim.g.vim_ai_complete = chat_engine_config
vim.g.vim_ai_edit = chat_engine_config

-- Commands
vim.api.nvim_create_user_command('AICode', function(opts)
  local range = opts.range
  local args = opts.args or ''
  local prompt = 'Programming syntax is ' .. vim.bo.filetype .. ', ' .. args
  vim.fn['vim_ai#AIRun'](range, prompt)
end, { range = true, nargs = '?' })

vim.api.nvim_create_user_command('GitCommitMessage', function()
  local diff = vim.fn.system 'git --no-pager diff --staged'
  local prompt = 'Generate a short commit message from the diff below:\n'
    .. diff
    .. '\n'
    .. 'Also provide its commit body message if needed. Do not '
    .. 'include any formatter nor summary and body labeling.'
  local config = {
    engine = 'chat',
    options = {
      initial_prompt = '>>> system\nYou are a code assistant.',
      temperature = 1,
    },
  }
  vim.fn['vim_ai#AIRun'](0, config, prompt)
end, {})

vim.api.nvim_create_user_command('CodeReview', function(opts)
  local range = opts.range
  local prompt = 'programming syntax is ' .. vim.bo.filetype .. ', review the code below'
  local config = {
    options = {
      initial_prompt = '>>> system\nYou are a clean code expert',
    },
  }
  vim.fn['vim_ai#AIChatRun'](range, config, prompt)
end, { range = true })

--[[
function AIDictFn()
  local word = vim.fn.expand '<cword>'
  local prompt = "Provide the IPA and the meaning of the word '" .. word .. "' in all of its parts of speech." .. ' Do not give any text formatter.'
  local config = {
    options = {
      initial_prompt = '>>> system\nYou are the American Oxford Dictionary. ',
      temperature = 1,
    },
  }
  vim.fn['vim_ai#AIChatRun'](0, config, prompt)
end
--]]

vim.api.nvim_create_user_command('AICDict', function(opts)
  local range = opts.range
  local prompt = 'Provide the pinyin and the meaning of the word in all of ' .. 'its parts of speech. Do not give any text formatter'
  local config = {
    options = {
      initial_prompt = '>>> system\nYou are a Chinese to English Dictionary. ',
      temperature = 1,
    },
  }
  vim.fn['vim_ai#AIChatRun'](range, config, prompt)
end, { range = true })
