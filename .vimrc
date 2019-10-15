set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins hosted on GitHub
Plugin 'tpope/vim-fugitive'                 " git wrapper
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}  " sublime-style fast HTML tags
Plugin 'ervandew/supertab'                  " smart TAB-completion
Plugin 'SirVer/ultisnips'                   " snippet manager <3
Plugin 'tomtom/tcomment_vim'                " commenting
Plugin 'ctrlpvim/ctrlp.vim'                 " fuzzy finder (file/buffer/mru/tag)
Plugin 'scrooloose/nerdtree'                " interactive filetree explorer
Plugin 'scrooloose/syntastic'               " awesome syntax checking
Plugin 'ycm-core/YouCompleteMe'             " code completion
Plugin 'mbbill/undotree'                    " undo history visualizer
Plugin 'terryma/vim-multiple-cursors'       " sublime-style multiple cursors
Plugin 'vim-airline/vim-airline'          " sexy & configurable statusline
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'tpope/vim-commentary'
" Plugin 'kevinw/pyflakes-vim'
" plugin from http://vim-scripts.org/vim/scripts.html
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" Git plugins not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'            " fast fuzzy filesearch
" Local Git plugin repos
Plugin 'file:///home/allison/.vim/plugin/vim-clipper'   " sys clipboard access

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

let mapleader=","

" Clipboard
set undodir=~/.vim/undodir
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
set showcmd	    " display incomplete commands
set cmdwinheight=20 " big window for command history (q:, q/, q?)

" filesystem
set autoread        " read file if it changed outside Vim
set backupcopy=yes  " backup and autosave
set autowrite
set autowriteall

" line length fascism
" set textwidth=80
" if exists("&colorcolumn")
"     set colorcolumn=+1
"     hi ColorColumn ctermbg=black ctermfg=red
" endif
" 
" line length SOFTCORE fascism
set colorcolumn=81
hi ColorColumn ctermbg=black ctermfg=red

set noexrc                  " don't use local version of .(g)vimrc, .exrc
set background=dark
" set background=light
set fenc=utf-8 " UTF-8
set cpoptions=aABceFsmq
set hls                     " highlighted search results
set backspace=indent,eol,start  " make backspace a more flexible
"set backup " make backup files
set fileformats=unix,dos,mac " support all three, in this order
set hidden                  " you can change buffers without saving
set iskeyword+=_,$,@,%,#    " none of these are word dividers
set noerrorbells            " don't make noise
set number                  " turn on line numbers
set numberwidth=4           " We are good up to 9999 lines
set scrolloff=25            " Keep n lines (top/bottom) for scope
set showcmd                 " show the command being typed
set ruler                   " Always show current positions along the bottom
"set formatoptions=rq       " Automatically insert comment leader on return
set ignorecase              " case insensitive by default
set shiftwidth=4            " auto-indent amount when using cindent, >>, <<, etc
set softtabstop=4           " auto-indent amount when using tab or backspace
set expandtab               " no real tabs please!
set smarttab
set wrap                    " wraps at window edge by default
set linebreak               " break long lines (visually)
set mouse=n                 " enable scroll wheel in normal mode
set noshowmode              " don't show mode below statusline (which shows mode)
" statusline
let g:airline#extensions#default#layout = [
    \ ['a', 'c'],
    \ ['z']
    \ ]
let g:airline_section_z = "\ %3p%%\ %3l:%-2c\ "     " percentage and line/col
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'
let g:airline_mode_map = {
    \ "ic" : "INSERT",
    \ "ix" : "INSERT",
    \ }

" diff coloring (esp. fugitive)
" call s:h("diffAdded", {"fg": s:green })
" call s:h("diffRemoved", { "fg": s:red })
hi DiffAdd guifg=NONE ctermfg=NONE guibg=#4acf55 ctermbg=002 gui=NONE cterm=NONE
hi DiffChange guifg=NONE ctermfg=NONE guibg=#d3305e ctermbg=060 gui=NONE cterm=NONE
hi DiffDelete guifg=NONE ctermfg=NONE guibg=#c92d2a ctermbg=010 gui=NONE cterm=NONE
hi DiffText guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=reverse cterm=reverse


" Clipper
function! YankToClipboard(type, ...)
    if a:0      " invoked from Visual mode, use '< and '> marks
        exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        exe "normal! '[V']y"
    elseif a:type == 'block'
        exe "normal! `[\<C-V>`]y"
    else
        exe "normal! `[v`]y"
    endif
    execute ':Clip'
endfunction
nnoremap <silent> <leader>y :set opfunc=YankToClipboard<CR>g@
vnoremap <silent> <leader>y :<C-U>call YankToClipboard(visualmode(), 1)<CR>

" CommandT
let g:CommandTFileScanner="find"
let g:CommandTMaxFiles=500000

" Supertab
let g:SuperTabDefaultCompletionType = "<C-n>"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }
nnoremap <leader>s :SyntasticCheck<CR>
nnoremap <leader>sn :lnext<CR>
nnoremap <leader>sp :lprevious<CR>
nnoremap <leader>sc :lclose<CR>
nnoremap <leader>sr :SyntasticReset<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<S-TAB>"

" youCompleteMe
" let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py"
let g:ycm_key_list_select_completion = ["<C-n>", "<Down>"]
let g:ycm_key_list_previous_completion = ["<C-p>", "<Up>"]
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

" fixes highlight bg color w/ light bgs
"hi Visual term=reverse cterm=reverse guibg=LightGrey

" undo-tree
nnoremap <leader><C-r> :UndotreeToggle<CR>
if has("persistent_undo")
    set undodir=~/.vim/undodir/
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
" fix whitespace
nnoremap <leader>fw :FixWhitespace<CR>

" quickly un-highlight search results
nnoremap <silent> <leader>l :nohl<CR>

" pastetoggle with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" switch panes with CTRL + [vim directional key]
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
