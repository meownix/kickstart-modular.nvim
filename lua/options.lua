-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--[[
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
--]]

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = false

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 0

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Below configurations are taken from my ~/.vimrc
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true

vim.wo.wrap = false

-- Enable filetype detection, plugins, and indentation
vim.cmd 'filetype plugin indent on'

-- First autocommand group (vimrcEx)
local vimrcEx = vim.api.nvim_create_augroup('vimrcEx', { clear = true })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vimrcEx,
  pattern = '*',
  callback = function()
    vim.bo.textwidth = 80
  end,
  desc = 'Set textwidth=80 for all files',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vimrcEx,
  pattern = '*.tex',
  callback = function()
    vim.bo.textwidth = 0
  end,
  desc = 'Set textwidth=0 for .tex files',
})

vim.api.nvim_create_autocmd('BufReadPost', {
  group = vimrcEx,
  pattern = '*',
  callback = function()
    local line = vim.fn.line '\'"'
    if line > 1 and line <= vim.fn.line '$' then
      vim.cmd 'normal! g`"'
    end
  end,
  desc = 'Restore cursor position',
})

-- Second autocommand group (vimrcNchat)
local vimrcNchat = vim.api.nvim_create_augroup('vimrcNchat', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  group = vimrcNchat,
  pattern = 'compose.txt',
  callback = function()
    vim.bo.textwidth = 0
    vim.wo.wrap = true
  end,
  desc = 'set tw to 0 and wrap for nchat',
})

-- vim: ts=2 sts=2 sw=2 et
