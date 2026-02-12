-- Global variable to store the previous foldmethod
local original_fdm = 'manual'

-- Function to fold lines that do not match the last search pattern
local function fold_non_matches()
  original_fdm = vim.wo.foldmethod -- Save current fdm
  vim.wo.foldexpr = 'getline(v:lnum)!~@/' -- Set filter logic
  vim.wo.foldmethod = 'expr' -- Enable expr mode
  vim.cmd 'normal! zM' -- Close all folds
end

-- Function to open all folds and restore the original foldmethod
local function restore_folds()
  vim.cmd 'normal! zR' -- Open all folds
  vim.wo.foldmethod = original_fdm -- Restore original fdm
end

-- Keybindings
-- <leader>z: Fold text that does not match search criteria
vim.keymap.set('n', '<leader>z', fold_non_matches, { desc = 'Fold non-matching search results' })

-- zq: Unfold everything and revert fdm back to original
vim.keymap.set('n', '<leader>x', restore_folds, { desc = 'Restore original foldmethod' })
