call plug#begin('~/.local/share/nvim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'nathanielc/vim-tickscript'

call plug#end()

" Lightline
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'gitbranch', 'fileformat', 'fileencoding', 'filetype'] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ }
  \ }

set noshowmode

" nord-vim
colorscheme nord
if (has("termguicolors"))
  set termguicolors
endif

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <M-n> :NERDTreeFind<CR>

let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-gitgutter
set signcolumn=yes
autocmd BufWritePost * GitGutter

" vim-tickscript
let g:tick_fmt_autosave = 0
