""""""" Plugin management stuff
let g:python_host_prog = '/usr/bin/python'
set shell=bash
set nocompatible
syntax on
filetype off

set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin('~/.nvim/bundle')

Plugin 'gmarik/Vundle.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'notpratheek/vim-luna'
Plugin 'Shougo/deoplete.nvim'
" Custom plugins...
" EasyMotion - Allows <leader><leader>(b|e) to jump to (b)eginning or (end)
" of words.
Plugin 'easymotion/vim-easymotion'
" Ctrl-P - Fuzzy file search
Plugin 'ctrlpvim/ctrlp.vim'
" Neomake build tool (mapped below to <c-b>)
Plugin 'benekastah/neomake'
" Remove extraneous whitespace when edit mode is exited
Plugin 'thirtythreeforty/lessspace.vim'

" Screen splitter.  Cool, but doesn't work with nvim.
"Plugin 'ervandew/screen'

" LaTeX editing
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Status bar mods
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'


Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/syntastic'
Plugin 'editorconfig-vim'

" Tab completion
Plugin 'scrooloose/nerdtree'
" Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'jistr/vim-nerdtree-tabs'
" Web stuff
Plugin 'pangloss/vim-javascript'
Plugin 'https://github.com/hail2u/vim-css3-syntax.git'
Plugin 'https://github.com/skammer/vim-css-color.git'
Plugin 'groenewege/vim-less'

" Python
Plugin 'python.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'davidhalter/jedi'
Plugin 'zchee/deoplete-jedi'
Plugin 'davidhalter/jedi-vim'
" Plugin 'andviro/flake8-vim'

" Git
Plugin 'https://github.com/tpope/vim-fugitive'

" After all plugins...
call vundle#end()
filetype plugin indent on

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

""""""" Jedi-VIM """""""
" Don't mess up undo history
let g:jedi#show_call_signatures = "0"

set encoding=utf-8
let python_highlight_all=1


""""""" General coding stuff """""""
set cursorline
" Highlight 80th column
set colorcolumn=80
" Always show status bar
set laststatus=2
" Let plugins show effects after 500ms, not 4s
set updatetime=500
" Disable mouse click to go to position
set mouse-=a
" Don't let autocomplete affect usual typing habits
set completeopt=menuone,preview,noinsert
" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

set noeb vb t_vb=
au GUIEnter * set vb t_vb=

set hls " highlight search terms (:noh to turn off temporarily)
set ignorecase " ignore case for searches (:set noignorecase to turn off)
set incsearch " search as you type
colorscheme darkblue " slightly nicer colour scheme
set scrolloff=10 " keep 15 lines of context on both sides of cursor when scrollin

 " display improvements
set list
" show indents
set ruler
set showcmd
set listchars=tab:»·,trail:·
set backupdir=~/.nvim/bak
set directory=~/.nvim/tmp


" If your terminal's background is white (light theme), uncomment the following
" to make EasyMotion's cues much easier to read.
" hi link EasyMotionTarget String
" hi link EasyMotionShade Comment
" hi link EasyMotionTarget2First String
" hi link EasyMotionTarget2Second Statement

" Syntastic
set ofu=syntaxcomplete#Complete
let g:syntastic_mode_map={ 'mode': 'active',
\ 'active_filetypes': [],
\ 'passive_filetypes': ['html', 'cpp'] }
let g:syntastic_check_on_open=1


""""""" Python stuff """""""
syntax enable
set number showmatch
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
let python_highlight_all = 1

" Speed up response to ESC key
set notimeout
set ttimeout
set timeoutlen=100

""""""" Keybindings """""""
" Set up leaders
let mapleader=","
let maplocalleader="\\"

" Arrow keys up/down move visually up and down rather than by whole lines.  In
" other words, wrapped lines will take longer to scroll through, but better
" control in long bodies of text.
" NOTE - Disabled since <leader><leader>w|e|b works well with easymotion
"noremap <up> gk
"noremap <down> gj

" Neomake and other build commands (ctrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>

autocmd BufNewFile,BufRead *.tex,*.bib noremap <buffer> <C-b> :w<cr>:new<bar>r !make<cr>:setlocal buftype=nofile<cr>:setlocal bufhidden=hide<cr>:setlocal noswapfile<cr>
autocmd BufNewFile,BufRead *.tex,*.bib imap <buffer> <C-b> <Esc><C-b>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

let g:airline_powerline_fonts = 1
colorscheme luna-term
map <C-n> :NERDTreeTabsToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'file', 'omni']
let g:deoplete#sources.python = ['buffer', 'file', 'omni']
au FileType python setlocal formatprg=autopep8\ -
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '^V' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ 't' : 'T',
      \ }

" Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1

" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'
"
" autocmd CompleteDone * pclose
"
let g:flake8_show_in_gutter=1

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
