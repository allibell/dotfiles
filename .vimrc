set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'file:///home/allison/.vim/plugin/vim-clipper'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'ervandew/supertab'
Plugin 'tomtom/tcomment_vim'
" Plugin 'tpope/vim-commentary'
" Plugin 'kevinw/pyflakes-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'YouCompleteMe', {'pinned': 1}
Plugin 'mbbill/undotree'
" sublime-style multiple cursors
Plugin 'terryma/vim-multiple-cursors'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append ! to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append ! to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append ! to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
"
"
" Clipboard
set clipboard=unnamed

" line number
set number


" FB Vim config
if filereadable($LOCAL_ADMIN_SCRIPTS . "/master.vimrc")
  source $LOCAL_ADMIN_SCRIPTS/master.vimrc
  source $LOCAL_ADMIN_SCRIPTS/vim/filetype.vim
  source /home/engshare/admin/scripts/vim/biggrep.vim
  " source $LOCAL_ADMIN_SCRIPTS/vim/fbvim.vim
endif

set gdefault " global substitute by default
set showmatch

" command editing
set showcmd	" display incomplete commands
set cmdwinheight=20 " big window for command history (q:, q/, q?)

" read file if changed outside vim
set autoread
" backup and autosave
set backupcopy=yes
set autowrite
set autowriteall
"
" line length fascism
" set textwidth=80
" if exists("&colorcolumn")
"   set colorcolumn=+1
"   hi ColorColumn ctermbg=black ctermfg=red
" endif
"
let mapleader=","

" fix whitespace
nnoremap <leader>fw :FixWhitespace<CR>

set noexrc " don't use local version of .(g)vimrc, .exrc
set background=dark " we plan to use a dark background
" set background=light
set fenc=utf-8 " UTF-8
set cpoptions=aABceFsmq
set hls "highlighted search results"
set backspace=indent,eol,start " make backspace a more flexible
"set backup " make backup files
set clipboard=unnamedplus " share windows clipboard
set fileformats=unix,dos,mac " support all three, in this order
set hidden " you can change buffers without saving
set iskeyword+=_,$,@,%,# " none of these are word dividers
set noerrorbells " don't make noise
set number " turn on line numbers
set numberwidth=4 " We are good up to 9999 lines
set scrolloff=25 " Keep n lines (top/bottom) for scope
set showcmd " show the command being typed
set ruler " Always show current positions along the bottom
"set formatoptions=rq " Automatically insert comment leader on return, and
set ignorecase " case insensitive by default
set nowrap " do not wrap line
set shiftwidth=4 " auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=4 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
set expandtab " no real tabs please!
set smarttab
set wrap " wraps at window edge by default
set linebreak " wraps at word breaks
set mouse=a " enable scroll wheel

" it2copy support
vmap <leader>c <esc>:'<,'>:w !~/bin/it2copy<CR><CR>

" youCompleteMe
let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_insertion = 1 " this window is quite annoying
let g:ycm_min_num_identifier_candidate_chars=4
let g:ycm_error_symbol='x'
let g:ycm_warning_symbol='!'
" nnoremap <leader>y :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>

" terminal-specific magic
let s:iterm   = exists('$ITERM_PROFILE') || exists('$ITERM_SESSION_ID') || filereadable(expand("~/.vim/.assume-iterm"))
let s:screen  = &term =~ 'screen'
let s:tmux    = exists('$TMUX')
let s:xterm   = &term =~ 'xterm'

if s:screen || s:xterm
  function! s:BeginXTermPaste(ret)
    set paste
    return a:ret
  endfunction

  " enable bracketed paste mode on entering Vim
  let &t_ti .= "\e[?2004h"

  " disable bracketed paste mode on leaving Vim
  let &t_te = "\e[?2004l" . &t_te

  set pastetoggle=<Esc>[201~
  inoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("")
  nnoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("i")
  vnoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("c")
  cnoremap <Esc>[200~ <nop>
  cnoremap <Esc>[201~ <nop>
endif

" fixes highlight bg color w/ light bgs
"hi Visual term=reverse cterm=reverse guibg=LightGrey

" undo-tree
nnoremap <leader><C-r> :UndotreeToggle<cr>
if has("persistent_undo")
    set undodir=~/local/.undodir/
    set undofile
endif

" nerdTree
nnoremap <leader>d :NERDTreeToggle %<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" signify ignore other vcs
" let g:signify_vcs_list = [ 'hg', 'git' ]

" faster norm mode for airline
set ttimeoutlen=8

" paste without overwriting pasteboard with deleted text.
xnoremap p pgvy

" fix indentations with F7
map <F7> gg=G<C-o><C-o>
