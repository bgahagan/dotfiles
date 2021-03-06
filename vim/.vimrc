set nocompatible                  " this enables lots of good stuff
filetype off                      " required by Vundle

" Use Vundle to manage plugins: https://github.com/gmarik/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" Vundle needs to manage itself
Plugin 'gmarik/vundle'

"Bundle 'tpope/vim-fireplace'
"Bundle 'overthink/vim-classpath'
"Bundle 'guns/vim-clojure-static'
"Bundle 'ervandew/supertab'
"Bundle 'majutsushi/tagbar'
"Bundle 'xolox/vim-session.git'
"Bundle 'L9'
"Bundle 'FuzzyFinder'
"Bundle 'elmcast/elm-vim'
"Plugin 'dyng/ctrlsf.vim'
Plugin 'tpope/vim-sensible'
Plugin 'derekwyatt/vim-scala'
Plugin 'tpope/vim-markdown'
"Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'mileszs/ack.vim'
Plugin 'dracula/vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'roxma/vim-tmux-clipboard'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'pbogut/fzf-mru.vim'
Plugin 'rust-lang/rust.vim'
"Plugin 'svermeulen/vim-cutlass' "Delete operations are sent to the black hole register
"Plugin 'ryanpcmcquen/fix-vim-pasting' "Enter paste mode when pasting from terminal/tmux
Plugin 'chrisjohnson/vim8-bracketed-paste-mode-tmux'

" All of your Plugins must be added before the following line
call vundle#end()
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
au CursorHold * :silent! checktime "check for changes after and idle timeout
au FocusGained,BufEnter * :silent! checktime " reload when entering the buffer or gaining focus

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=2
set softtabstop=2

" Force 2 paces for python
au Filetype python setl et ts=2 sw=2

set backupdir=~/.vim/backup/
set nobackup
set directory=~/.vim/tmp//
set noswapfile
set undodir=~/.vim/undo//
set undofile

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
"set numberwidth=3
set cursorline          " highlight current line

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

" Allow changing buffer even if unsaved
set hidden

" Set off the other paren
"highlight MatchParen ctermbg=4


" Favorite Color Scheme
if has("gui_running")
  "colorscheme inkpot
  colorscheme dracula
  " Remove Toolbar
  set guioptions-=T
  "Terminus is AWESOME
  set guifont=Terminus\ 9
else

  if &term =~# '256color'
    "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set t_8f=[38;2;%lu;%lu;%lum        " set foreground color
    set t_8b=[48;2;%lu;%lu;%lum        " set background color
    set t_Co=256
    set termguicolors
  endif
  "set background=dark
  " colorscheme metacosm
  " colorscheme zellner
  let g:jellybeans_overrides = {
  \    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
  \}
  colorscheme jellybeans
  let g:airline_theme='jellybeans'
  "let g:airline#extensions#tabline#enabled = 1
  "if (has("termguicolors"))
  "  set termguicolors
  "endif
  "set background=dark

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
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<C-x><C-o>"
"let g:SuperTabClosePreviewOnPopupClose = 1
"au FileType *
"  \ if &omnifunc != '' |
"  \   call SuperTabChain(&omnifunc, "<c-x><c-n>") |
"  \   call SuperTabSetDefaultCompletionType("<c-x><c-o>") |
"  \ endif

" vim-fireplace clojure mappings
au FileType clojure map <localleader>q :w<CR>:Require!<CR>
" reset:  http://thinkrelevance.com/blog/2013/06/04/clojure-workflow-reloaded
au FileType clojure map <localleader>r :w<CR>:Eval (user/reset)<CR>
au FileType clojure map <localleader>t :w<CR>:Require<CR>:Eval (user/test)<CR>
au FileType clojure map <localleader>T :w<CR>:Require<CR>:Eval (user/test-all)<CR>

"#################
" Ctrl-P Options
" ################
"
" Show buffers in results as well
let g:ctrlp_cmd = 'CtrlPMixed'
" Start search for current working dir
let g:ctrlp_working_path_mode = 'a'
" Most recently used first (I think?)
let g:ctrlp_mruf_relative = 1
" Show top 20 results
let g:ctrlp_match_window = 'bottom,order:ttb,max:20'
"noremap <C-[> :CtrlPBuffer<CR>
"inoremap <C-[> :CtrlPBuffer<CR>
"cnoremap <C-[> :CtrlPBuffer<CR>
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ -g ""'


"#################
" Ack Options
" ################
"
" Use ag if availiable
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"#################
" CtrlSF Options
" ################
"
let g:ctrlsf_auto_close = {
    \ "normal" : 1,
    \ "compact": 1
    \}
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_position = 'bottom'

"nmap     <C-F>f <Plug>CtrlSFPrompt
"vmap     <C-F>f <Plug>CtrlSFVwordPath
"vmap     <C-F>F <Plug>CtrlSFVwordExec
"nmap     <C-F>n <Plug>CtrlSFCwordPath
"nmap     <C-F>p <Plug>CtrlSFPwordPath
"nnoremap <C-F>o :CtrlSFOpen<CR>
"nnoremap <C-F>t :CtrlSFToggle<CR>
"inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

"##############################################################################
" Mappings
"##############################################################################
"
" Alt-] to open a tag in a new split
"map <A-]> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

"set some mappings to easly cycle through buffers
noremap <C-Tab> :bnext<CR>
inoremap <C-Tab> <Esc>:bnext<CR>
cnoremap <C-Tab> :bnext<CR>

noremap <C-S-Tab> :bprev<CR>
inoremap <C-S-Tab> <Esc>:bprev<CR>
cnoremap <C-S-Tab> :bprev<CR>

" a handy mapping to fix tabs and kill trailing whitespace
map <F11> m`:retab<CR>:%s/\s\+$//eg<CR>``

" a mapping to refresh the syntax colouring easily -- this is really only
" useful when writing syntax files.
map <F12> :syn sync fromstart<CR>

"##############################################################################
" Easier split navigation
"##############################################################################

" Use ctrl-[hjkl] to select the active split! (http://www.vim.org/tips/tip.php?tip_id=173)
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
" faster splits and tabs
map <leader>v :vsplit<CR>
map <leader>s :split<CR>
map <leader>c :close<CR>
" open current split in new tab
map <leader>t <C-W>T

" ## FZF config ##
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Bind Ctrl-P to Files search
noremap <C-P> :Files<CR>
inoremap <C-P> <Esc>:Files<CR>
cnoremap <C-P> :Files<CR>

" cutlass changes dd be delete rather than cut. re-add a cut(move) key
"nnoremap m d
"xnoremap m d
"nnoremap mm dd
"nnoremap M D
