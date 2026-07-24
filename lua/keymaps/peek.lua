-- Keymaps for peek.nvim (Markdown Preview)
vim.keymap.set('n', '<leader>op', '<cmd>PeekOpen<CR>', { desc = '[O]pen Markdown [P]review (Peek)' })
vim.keymap.set('n', '<leader>cp', '<cmd>PeekClose<CR>', { desc = '[C]lose Markdown [P]review (Peek)' })

vim.keymap.set('n', '<leader>tp', function()
  local peek = require('peek')
  local current_theme = require('peek.config').get('theme')
  local next_theme = current_theme == 'dark' and 'light' or 'dark'
  
  local is_open = peek.is_open()
  if is_open then
    peek.close()
  end
  
  peek.setup({ theme = next_theme })
  
  -- If it was open, briefly wait for the old process to close then reopen
  if is_open then
    vim.defer_fn(function()
      peek.open()
    end, 100)
  else
    print('Peek theme set to: ' .. next_theme)
  end
end, { desc = '[T]oggle Markdown [P]review Theme (Peek)' })

-- vim: ts=2 sts=2 sw=2 et
