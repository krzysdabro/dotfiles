local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-h>', '<C-W>h')
map('n', '<C-j>', '<C-W>j')
map('n', '<C-k>', '<C-W>k')
map('n', '<C-l>', '<C-W>l')
map('n', '<M-h>', '<C-w>H')
map('n', '<M-j>', '<C-w>J')
map('n', '<M-k>', '<C-w>K')
map('n', '<M-l>', '<C-w>L')

map('n', '<C-n>', ':NvimTreeToggle<CR>')

map('t', '<Esc><Esc>', '<C-\\><C-n>')
