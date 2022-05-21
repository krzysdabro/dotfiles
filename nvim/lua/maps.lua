vim.keymap.set('n', '<C-h>', '<C-W>h', { desc = 'jump to the window on the left' })
vim.keymap.set('n', '<C-j>', '<C-W>j', { desc = 'jump to the window below' })
vim.keymap.set('n', '<C-k>', '<C-W>k', { desc = 'jump to the window above' })
vim.keymap.set('n', '<C-l>', '<C-W>h', { desc = 'jump to the window on the right' })
vim.keymap.set('n', '<M-h>', '<C-W>H', { desc = 'move the window to the left' })
vim.keymap.set('n', '<M-j>', '<C-W>J', { desc = 'move the window below' })
vim.keymap.set('n', '<M-k>', '<C-W>K', { desc = 'move the window above' })
vim.keymap.set('n', '<M-l>', '<C-W>H', { desc = 'move the window to the right' })

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'toogle file explorer' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'exit terminal' })
