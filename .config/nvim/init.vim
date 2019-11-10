source ~/.config/nvim/plugins.vim

" General
set number                                       " Show line numbers
set cursorline                                   " Highlight current line
set list listchars=tab:→\ ,trail:·               " Display tabs and trailing spaces visually
set mouse=a                                      " Enable mouse support
set belloff=all                                  " Turn off bell

" Search
set ignorecase                                   " Case insensitive search patterns
set smartcase                                    " Override 'ignorecase' when pattern has uppercase
set magic                                        " Turn on regular expressions

" Tabs, indentation and wrapping
set tabstop=2                                    " Tabs width
set softtabstop=2
set shiftwidth=2
set expandtab                                    " Expand <tab> to spaces
set autoindent                                   " Automatically set the indent of a new line
set wrap                                         " Wrap long lines
set linebreak                                    " Wrap lines intelligently, e.g. by end of words
set breakindent                                  " Preserve indentation in wrapped text
set breakindentopt=shift:2                       " Shift wrapped line by 2 spaces
set breakat=\ /\()"':,.;<>~!@#$%^&*|+=[]{}`?-…

" Key mapping
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <M-h> <C-w>H
nnoremap <M-j> <C-w>J
nnoremap <M-k> <C-w>K
nnoremap <M-l> <C-w>L

tnoremap <Esc> <C-\><C-n>

" Commands
command! W write

" Terminal
augroup Terminal
  autocmd!
  autocmd TermOpen * setlocal nonumber            " Hide numer line
  autocmd TermOpen * startinsert                  " Start in insert mode
augroup end
