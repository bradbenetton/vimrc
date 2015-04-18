set nocompatible              " be iMproved, required
filetype off                  " required
set hidden
set undofile

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

Plugin 'https://github.com/morhetz/gruvbox'
Plugin 'https://github.com/SirVer/ultisnips'
Plugin 'https://github.com/honza/vim-snippets'
Plugin 'https://github.com/Valloric/YouCompleteMe'
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'https://github.com/maksimr/vim-jsbeautify'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'https://github.com/jiangmiao/auto-pairs'
Plugin 'https://github.com/scrooloose/nerdcommenter'
Plugin 'https://github.com/ervandew/supertab'
Plugin 'https://github.com/xolox/vim-misc'
Plugin 'https://github.com/xolox/vim-session'
Plugin 'https://github.com/vim-scripts/dbext.vim'
Plugin 'https://github.com/jeetsukumaran/vim-buffergator'
Plugin 'https://github.com/yegappan/mru'
Plugin 'https://github.com/Shutnik/jshint2.vim'
Plugin 'https://github.com/mattn/emmet-vim/'
Plugin 'https://github.com/kien/ctrlp.vim'
Plugin 'https://github.com/KabbAmine/vCoolor.vim'
Plugin 'https://github.com/yuratomo/w3m.vim'
Plugin 'https://github.com/schickling/vim-bufonly'
Plugin 'https://github.com/powerman/vim-plugin-ruscmd'
Plugin 'https://github.com/tpope/vim-surround'
Plugin 'https://github.com/Lokaltog/vim-easymotion'
Plugin 'https://github.com/Shougo/unite.vim'
Plugin 'https://github.com/gorodinskiy/vim-coloresque'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Theme settings
set background=dark
colorscheme gruvbox
set t_ZH=[3m " enable italics
set t_ZR=[23m " enable italics
" to display background properly inside tmux
set t_ut=

" Turn syntax on
filetype plugin on
syntax on
" Turn on line numbers
set number

" NERDTree settings
autocmd vimenter * call OnStart() " start automatically
" autocmd vimenter * wincmd w " start automatically
" autocmd vimenter * OpenSession! default " start automatically
" autocmd vimleave * SaveSession default
" autocmd bufleave * SaveSession default
" if !exists("StartNERDTree")
    " function StartNERDTree()
        " NERDTree
        " wincmd w
    " endfunction
    " endif
" autocmd vimenter StartNERDTree()

function OnStart()
    NERDTree
    wincmd w
endfunction

map <C-n> :NERDTreeToggle<CR>
" close Vim when only NERDTree and another buffer are opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Make backspace work
set backspace=2

" JS-Beautifier settings
" map <c-F> :call JsBeautify()<cr>
"autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
"autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
"autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" tab settings
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" UltiSnips settings
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:ycm_use_ultisnips_completer = 1

" NERDCommenter settings
let NERDSpaceDelims=1
let g:NERDCustomDelimiters = { 'javascript' : { 'left': '/**', 'right': '*/' } }


function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" vim-session settings
let g:session_autosave = 1
" let g:session_autoload = 1
let g:session_autoload = 'no'

" disable autocomments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" PGSQL Database Settings
let g:dbext_default_profile_PG = 'type=PGSQL:host=ec2-54-235-76-253.compute-1.amazonaws.com:dbname=d45f61kivq9f3p:user=gtzlehsaymrabv:passwd=JGj57ZPLkh5gtiB4eD7AO_tO4-:port=5432'

" copy and paste settings
set clipboard+=unnamed
" set paste

" JSBeatifier
map <Leader>f :call JsBeautify()<cr>

" BEMHTML syntax highlighter
autocmd BufNewFile,BufRead *.bemhtml set syntax=javascript

" CtrlP
map <c-p> :CtrlPBuffer<cr>
" let g:CtrlPBuffer = '<c-p>'

" VCoolor
map <Leader>v :VCoolor<cr>

" en spelling
setlocal spell spelllang=en_us

" w3m settings
let g:w3m#search_engine = 'https://www.google.ru/?gfe_rd=cr&ei=PqEnVfjbIIGr8wfj7IGQAw'
let g:w3m#lang = 'en_US'

autocmd BufEnter * :syntax sync fromstart

map <c-l> :bn<cr>
map <c-h> :bp<cr>

set history=1000


" function Test() range
    " echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| pbcopy')
" endfunction
highlight Comment cterm=italic
