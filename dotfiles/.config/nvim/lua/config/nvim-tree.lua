local tree_cb = require('nvim-tree.config').nvim_tree_callback
vim.g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}
vim.g.nvim_tree_special_files = {
  'README.md',
  'Makefile',
  'MAKEFILE',
  'CMakeLists.txt'
}
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_width = 25
vim.g.nvim_tree_bindings = {
  {key = "<CR>", cb = tree_cb("edit")},
  {key = "o", cb = tree_cb("edit")},
  {key = "<C-[>", cb = tree_cb("dir_up")},
  {key = "<C-]>", cb = tree_cb("cd")},
  {key = "<C-v>", cb = tree_cb("vsplit")},
  {key = "<C-x>", cb = tree_cb("split")},
  {key = "<C-t>", cb = tree_cb("tabnew")},
  {key = "<", cb = tree_cb("prev_sibling")},
  {key = ">", cb = tree_cb("next_sibling")},
  {key = "x", cb = tree_cb("close_node")},
  {key = "<S-CR>", cb = tree_cb("close_node")},
  {key = "<Tab>", cb = tree_cb("preview")},
  {key = "I", cb = tree_cb("toggle_ignored")},
  {key = "H", cb = tree_cb("toggle_dotfiles")},
  {key = "R", cb = tree_cb("refresh")},
  {key = "a", cb = tree_cb("create")},
  {key = "d", cb = tree_cb("remove")},
  {key = "r", cb = tree_cb("rename")},
  {key = "<C-r>", cb = tree_cb("full_rename")},
  {key = "-", cb = tree_cb("cut")},
  {key = "c", cb = tree_cb("copy")},
  {key = "p", cb = tree_cb("paste")},
  {key = "y", cb = tree_cb("copy_name")},
  {key = "Y", cb = tree_cb("copy_path")},
  {key = "gy", cb = tree_cb("copy_absolute_path")},
  {key = "[c", cb = tree_cb("prev_git_item")},
  {key = "]c", cb = tree_cb("next_git_item")},
  {key = "q", cb = tree_cb("close")}
}
