set nocompatible                  " this enables lots of good stuff
filetype off                      " required by Vundle

" Use Vundle to manage plugins: https://github.com/gmarik/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Vundle needs to manage itself
Bundle 'gmarik/vundle'

Bundle 'derekwyatt/vim-scala'
Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-fireplace'
Bundle 'overthink/vim-classpath'
Bundle 'guns/vim-clojure-static'
Bundle 'ervandew/supertab'
Bundle 'majutsushi/tagbar'
"Bundle 'xolox/vim-session.git'
"Bundle 'L9'
"Bundle 'FuzzyFinder'
Bundle "kien/ctrlp.vim"
Bundle 'tpope/vim-fugitive'

filetype plugin indent on

syntax on
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }

" Sets how many lines of history VIM has to remember
set history=700

set noerrorbells

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent
set si "Smart indet

" Auto read files when they change
set autoread

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=2
set softtabstop=2

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
  set spl=en spell
  set nospell
endif

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*/target/*,*/snapsort_data/*

" Enable mouse support in console
"set mouse=a

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" Line Numbers PWN!
"set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never
" type jj anyway, so it's great!
inoremap jj <Esc>

nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
"highlight MatchParen ctermbg=4


" Favorite Color Scheme
if has("gui_running")
   colorscheme inkpot
   " Remove Toolbar
   set guioptions-=T
   "Terminus is AWESOME
   set guifont=Terminus\ 9
else
  " colorscheme metacosm
  colorscheme zellner
  set background=dark

  set nonu
endif

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz


set tags=./tags,tags

let mapleader = ","
let maplocalleader = "\\"
set formatoptions+=l      " Don't break and auto-format long lines.
set formatoptions-=t      " Don't autoformat shit

" SuperTab config
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<C-x><C-o>"
let g:SuperTabClosePreviewOnPopupClose = 1
au FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-x><c-n>") |
  \   call SuperTabSetDefaultCompletionType("<c-x><c-o>") |
  \ endif

" vim-fireplace clojure mappings
au FileType clojure map <localleader>q :w<CR>:Require!<CR>
" reset:  http://thinkrelevance.com/blog/2013/06/04/clojure-workflow-reloaded
au FileType clojure map <localleader>r :w<CR>:Eval (user/reset)<CR>
au FileType clojure map <localleader>t :w<CR>:Require<CR>:Eval (user/test)<CR>
au FileType clojure map <localleader>T :w<CR>:Require<CR>:Eval (user/test-all)<CR>

"Ctrl-P Option
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 'c'
