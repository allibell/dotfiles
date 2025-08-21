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

" augroup MyRustBold
"   autocmd!
"   autocmd FileType rust highlight rustKeyword cterm=bold gui=bold
"   autocmd FileType rust highlight rustIdentifier gui=bold guifg=#005faf cterm=bold ctermfg=31
"   autocmd FileType rust highlight rustType cterm=bold gui=bold
"   autocmd FileType rust highlight rustLifetime cterm=bold gui=bold
"   autocmd FileType rust highlight rustAttribute cterm=bold gui=bold
" augroup END
"
"
"

augroup MyRustColors
  autocmd!
  " Base text
  autocmd FileType rust highlight Normal       gui=none guifg=#444444 cterm=none ctermfg=236
  autocmd FileType rust highlight Comment      gui=italic guifg=#878787 cterm=italic ctermfg=102
  autocmd FileType rust highlight Constant     gui=bold guifg=#5f8700 cterm=bold ctermfg=64
  autocmd FileType rust highlight rustDerive gui=bold guifg=#008700 cterm=bold ctermfg=28
  autocmd FileType rust highlight rustDeriveTrait gui=bold guifg=#008700 cterm=bold ctermfg=28

  " Keywords and control flow (blue)
  autocmd FileType rust highlight rustKeyword       gui=bold guifg=#0087af cterm=bold ctermfg=31
  autocmd FileType rust highlight rustConditional   gui=bold guifg=#af0000 cterm=bold ctermfg=124
  autocmd FileType rust highlight rustRepeat        gui=bold guifg=#af0000 cterm=bold ctermfg=124
  autocmd FileType rust highlight rustStorage       gui=bold guifg=#0087af cterm=bold ctermfg=31

  " Types and identifiers
  autocmd FileType rust highlight rustType          gui=bold guifg=#8700af cterm=bold ctermfg=91
  autocmd FileType rust highlight rustTrait         gui=bold guifg=#8700af cterm=bold ctermfg=91
  autocmd FileType rust highlight rustIdentifier    gui=bold guifg=#0087af cterm=bold ctermfg=31

  " Functions and macros
  autocmd FileType rust highlight rustFunction      gui=bold guifg=#d75f00 cterm=bold ctermfg=166
  autocmd FileType rust highlight rustMacro         gui=bold guifg=#d75f00 cterm=bold ctermfg=166
autocmd FileType rust highlight rustAssert        gui=bold guifg=#008700 cterm=bold ctermfg=28

  " Attributes & lifetimes
  autocmd FileType rust highlight rustAttribute     gui=bold guifg=#008700 cterm=bold ctermfg=28
  autocmd FileType rust highlight rustLifetime      gui=bold guifg=#5f8700 cterm=bold ctermfg=64
augroup END


" This Vim mapping inserts a timestamp when you press Ctrl+T in insert mode.
" Specifically:
"
" imap <C-t> creates a mapping that works in insert mode when you press Ctrl+T
" <C-R>= allows you to evaluate a Vim expression and insert the result
" strftime("[%m-%d-%A-%Y %I:%M %p]") formats the current time in the pattern:
" [month-day-dayofweek-year hour:minute AM/PM]
"
" For example, pressing Ctrl+T while in insert mode would insert something
" like:
" [04-20-Thursday-2023 02:30 PM
imap <C-t> <C-R>=strftime("`[%m-%d-%A-%Y %I:%M %p]`")<CR>

