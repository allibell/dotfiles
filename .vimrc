" ============================================================
" BASIC SETTINGS & ENVIRONMENT
" ============================================================
set nocompatible
filetype off
set clipboard=unnamed
if has("persistent_undo")
    set undodir=~/.vim/undodir/
    set undofile
endif
set number
set numberwidth=4
set scrolloff=25
set ruler
set showcmd
set showmatch
set backspace=indent,eol,start
set hidden
set autoread
set backupcopy=yes
set autowrite
set autowriteall
set noerrorbells
set hls
set ignorecase
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set wrap
set linebreak
set mouse=n
set noshowmode
set fileformats=unix,dos,mac
set iskeyword+=_,$,@,%,#

" Enable truecolor support and syntax highlighting
" set termguicolors
syntax enable

" Set leader key
let mapleader = ","

" ============================================================
" PLUGIN MANAGER (Vundle) & PLUGINS
" ============================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'honza/vim-snippets'
Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mbbill/undotree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-airline/vim-airline'
Plugin 'allibell/vim-airline-themes'
" Plugin 'NLKNguyen/papercolor-theme'
" Plugin 'challenger-deep-theme/vim'
Plugin 'wincent/vim-clipper'
Plugin 'goerz/jupytext.vim'
Plugin 'cespare/vim-toml'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'git://git.wincent.com/command-t.git'
" Plugin 'git://github.com/digitaltoad/vim-pug.git'

call vundle#end()
filetype plugin indent on

" ============================================================
" THEME & COLORSCHEME CONFIGURATION
" ============================================================
" if &background == "dark"
"     colorscheme challenger_deep
" else
"     colorscheme PaperColor
" endif
" autocmd OptionSet background if &background == "dark" | colorscheme challenger_deep | else | colorscheme PaperColor | endif

" ============================================================
" UI ENHANCEMENTS & AIRLINE CONFIG
" ============================================================
let g:airline#extensions#default#layout = [['a', 'c'], ['z']]
let g:airline_section_z = "\ %3p%%\ %3l:%-2c\ "
let g:airline_powerline_fonts = 1
" let g:airline_theme='deus'
let g:airline_theme='papercolor'
let g:airline_mode_map = {"ic" : "INSERT", "ix" : "INSERT"}

" ============================================================
" MISCELLANEOUS SETTINGS & MAPPINGS
" ============================================================
" Jupytext: default to Python format
let g:jupytext_fmt = "py"

" Yank to clipboard using vim-clipper
function! YankToClipboard(type, ...)
    if a:0
        exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        exe "normal! '[V']y"
    elseif a:type == 'block'
        exe "normal! `[\<C-V>`]y"
    else
        exe "normal!(`[v`]y"
    endif
    execute ':Clip'
endfunction
nnoremap <silent> <leader>y :set opfunc=YankToClipboard<CR>g@
vnoremap <silent> <leader>y :<C-U>call YankToClipboard(visualmode(), 1)<CR>

" Open markdown files in Chrome
autocmd BufEnter *.md exe 'noremap <F5> :!google-chrome %:p<CR>'

" Command-T settings
let g:CommandTFileScanner="find"
let g:CommandTMaxFiles=500000

" Terminal-specific detection (for iterm, screen, tmux)
let s:iterm   = exists('$ITERM_PROFILE') || exists('$ITERM_SESSION_ID') || filereadable(expand("~/.vim/.assume-iterm"))
let s:screen  = &term =~ 'screen'
let s:tmux    = exists('$TMUX')

" Undotree toggle
nnoremap <leader><C-r> :UndotreeToggle<CR>

" NERDTree mappings
nnoremap <leader>d :NERDTreeToggle %<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Faster normal mode for airline
set ttimeoutlen=8

" Prevent paste register overwrite in visual mode
xnoremap p pgvy

" Fix indentation and whitespace
map <F7> gg=G<C-o><C-o>
nnoremap <leader>fw :FixWhitespace<CR>

" Quick un-highlight search
nnoremap <silent> <leader>l :nohl<CR>

" Toggle paste mode with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Window pane switching with Ctrl + [h,j,k,l]
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" FZF integration (if installed)
set rtp+=/opt/homebrew/opt/fzf
