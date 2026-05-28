return {
  'lervag/vimtex',
  -- lazy = false, -- Recommended to avoid initialization issues
  init = function()
    vim.g.vimtex_view_method = 'sioyek' -- or 'skim', 'mupdf', etc.
  end,
}
