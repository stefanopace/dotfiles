" Rimappa il tasto esc su jk
inoremap jk <ESC>

syntax on

set encoding=utf-8

set clipboard=unnamedplus

set number relativenumber
set tabstop=3
set list listchars=tab:\|·,trail:␣
highlight SpecialKey ctermfg=DarkGrey guifg=grey70

" evidenzia il carattere nella colonna 81
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

call plug#begin()
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'elixir-editors/vim-elixir'
call plug#end()
