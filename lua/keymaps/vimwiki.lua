local myWiki = {
  path = vim.env.HOME .. '/Documents/vimwiki/doc/',
  path_html = vim.env.HOME .. '/Documents/vimwiki/html/',
  template_path = vim.env.HOME .. '/Documents/vimwiki/templates/',
  auto_toc = 1,
  auto_tags = 1,
  vimwiki_use_calendar = 1,
}

if vim.env.myInten == 'Personal' then
  local officeWiki = {
    path = vim.env.HOME .. '/Documents/Office.wiki/team/doc/',
    path_html = vim.env.HOME .. '/Documents/Office.wiki/team/html/',
    template_path = vim.env.HOME .. '/Documents/Office.wiki/team/templates/',
    auto_toc = 1,
    auto_tags = 1,
  }

  vim.g.vimwiki_list = { myWiki, officeWiki }
  vim.g.peekaboo_template_dir = myWiki.template_path
else
  local myOfficeWork = {
    path = vim.env.HOME .. '/Documents/Office.wiki/mine/vimwiki/',
    path_html = vim.env.HOME .. '/Documents/Office.wiki/mine/vimwiki_html/',
    template_path = vim.env.HOME .. '/Documents/Office.wiki/mine/templates/',
    auto_toc = 1,
    auto_tags = 1,
  }

  local myJoblog = {
    path = vim.env.HOME .. '/Documents/Office.wiki/joblog/doc/',
    path_html = vim.env.HOME .. '/Documents/Office.wiki/joblog/html/',
    template_path = vim.env.HOME .. '/Documents/Office.wiki/mine/templates/',
    auto_toc = 1,
    auto_tags = 1,
  }

  local teamWiki = {
    path = vim.env.HOME .. '/Documents/Office.wiki/team/doc/',
    path_html = vim.env.HOME .. '/Documents/Office.wiki/team/html/',
    template_path = vim.env.HOME .. '/Documents/Office.wiki/team/templates/',
    auto_toc = 1,
    auto_tags = 1,
  }

  local teamWorkshop = {
    path = vim.env.HOME .. '/Documents/Office.wiki/MWorkshop/doc/',
    path_html = vim.env.HOME .. '/Documents/Office.wiki/MWorkshop/html/',
    template_path = vim.env.HOME .. '/Documents/Office.wiki/MWorkshop/templates/',
    auto_toc = 1,
    auto_tags = 1,
  }

  local teamMWiki = {
    path = vim.env.HOME .. '/Documents/Office.wiki/MWiki/doc/',
    path_html = vim.env.HOME .. '/Documents/Office.wiki/MWiki/html/',
    template_path = vim.env.HOME .. '/Documents/Office.wiki/MWiki/templates/',
    auto_toc = 1,
    auto_tags = 1,
  }

  vim.g.vimwiki_list = { myWiki, myOfficeWork, myJoblog, teamWiki, teamWorkshop, teamMWiki }

  vim.keymap.set('n', '<leader>mom', ':tag momIndex<cr>')
  vim.keymap.set('n', '<leader>gpg', ':tag gpgIndex<cr>')
  vim.keymap.set('n', '<leader>tex', ':tag texIndex<cr>')
  vim.keymap.set('n', '<leader>srs', ':tag srsIndex<cr>')
  vim.keymap.set('n', '<leader>std', ':tag stdIndex<cr>')
  vim.keymap.set('n', '<leader>nix', ':tag linuxIndex<cr>')
end

vim.g.vimwiki_folding = 'custom'
vim.g.vimwiki_create_link = 0
