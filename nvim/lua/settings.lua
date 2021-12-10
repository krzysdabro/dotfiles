local opt = vim.opt

-- Show line number
opt.number = true
opt.relativenumber = false

-- Highlight current line
opt.cursorline = true

-- Enable mouse in all modes
opt.mouse = "a"

-- Search options
opt.ignorecase = true
opt.smartcase = true
opt.magic = true

-- Tabs, indentation and wrapping options
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = {shift = 2}
opt.breakat = ' /()\"\':,.;<>~!@#$%^&*|+=[]{}`?-…'
opt.list = true
opt.listchars = { tab = '→ ', trail = '·' }
