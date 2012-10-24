set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
set rtp +=~/.vim.local/
call vundle#rc()

Bundle 'gmarik/vundle'

"" Plugins
Bundle 'mileszs/ack.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

Bundle 'majutsushi/tagbar'

Bundle 'tpope/vim-fugitive'

Bundle 'Lokaltog/vim-easymotion'

Bundle 'vim-scripts/ZoomWin'

Bundle 'scrooloose/syntastic'

" Tab smart completion
Bundle 'ervandew/supertab'

Bundle 'scrooloose/nerdcommenter'
" Colors hex values in CSS files
Bundle 'ap/vim-css-color'

" Autocloses if->endif, etc...
Bundle 'tpope/vim-endwise'
" Allows changing surrounding delimeters
Bundle 'tpope/vim-surround'

" Allows more things to be '.'ed
Bundle 'tpope/vim-repeat'

" Helps with unix neckbeardy stuff
Bundle 'tpope/vim-eunuch'

" Vim personal wiki. hooked into trunknotes for me
Bundle 'vim-scripts/vimwiki'


" CVS (git,hg...) functionality
Bundle 'vim-scripts/aurum'

" Better status bar
" Bundle 'default/vim-powerline'

" Escapes ANSI codes
Bundle 'vim-scripts/AnsiEsc.vim'

" Resizes panes to a nicer ration
Bundle 'roman/golden-ratio'

Bundle 'vim-scripts/ShowMarks7'

" Fuzzy file finding
Bundle 'kien/ctrlp.vim'

" Better pasting
Bundle 'sickill/vim-pasta'

" Colors parens
Bundle 'kien/rainbow_parentheses.vim'

" Automatically closes quotes, parenthesis, brackets, etc.
Bundle 'Raimondi/delimitMate'

Bundle 'nathanaelkane/vim-indent-guides'

" 3-way merge manager
Bundle 'sjl/splice.vim'

" Indent finder
Bundle 'Raimondi/YAIFA'

" looks for todos
Bundle 'vim-scripts/TaskList.vim'

" Matching if/endif, not just {} [] ()
Bundle 'vim-scripts/matchit.zip'

" Python stuff
"Bundle 'klen/python-mode'

"" Syntaxes
Bundle 'vim-scripts/Arduino-syntax-file'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'pangloss/vim-javascript'
Bundle 'mmalecki/vim-node.js'
"Bundle 'tpope/vim-markdown'
Bundle 'vim-ruby/vim-ruby'
Bundle 'https://github.com/ChrisYip/Better-CSS-Syntax-for-Vim.git'
Bundle 'othree/html5.vim'



" Colors
Bundle 'altercation/vim-colors-solarized'

" Configuration
syntax on        " turn on hilighting
let g:Powerline_symbols = 'fancy'
let g:Powerline_stl_path_style = 'filename'
let g:Powerline_theme = 'skwp'
let g:Powerline_colorscheme = 'skwp'
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set laststatus=2
set t_Co=256
set number
set showmode
set showcmd
set splitbelow
set splitright
"set visualbell
set hidden
set ignorecase
set smartcase
"filetype plugin on
filetype indent on
filetype plugin indent on
let mapleader = ","
let LocalLeader = ";"
noremap <leader>w :w<CR>
noremap <leader>W :w!sudo tee %
noremap <leader>q :q<CR>
noremap <leader>n :bnext<CR>
noremap <leader>N :bprevious<CR>
noremap <leader>ev :vsplit ./
noremap <leader>eh :vsplit ./
nnoremap ' `
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>G <Plug>(golden_ratio_resize)
let g:golden_ratio_autocommand = 1
nnoremap ` '
nnoremap <Leader>S :%s//<left>
inoremap jj <Esc>

set backup
set autowrite
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start

" Highlight search terms...
set hlsearch
set incsearch
set shortmess=atI
set modelines=0
set autoindent
set wrap
"" TABBING
set tabstop=4
" Set soft tabs equal to 4 spaces.
set softtabstop=4
" Set auto indent spacing.
set shiftwidth=4
" " Shift to the next round tab stop.
set shiftround
set smartindent
set smarttab
set expandtab
set nolist
" List of characters to show instead of whitespace.
set listchars=tab:▸\ ,eol:¬,trail:⌴,extends:❯,precedes:❮
let &showbreak=nr2char(8618).' '
set linebreak
set ttyfast
set ruler
set showmatch
set matchtime=3
set matchpairs+=<:>
set printoptions+=syntax:y
set printoptions+=number:y
set cf
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable

set wildmenu

" Enable completion on tab.
set wildchar=<Tab>

" Insert mode completion.
set completeopt=longest,menu,preview

" Wildcard expansion completion.
set wildmode=list:longest,list:full

" Keyword completion for when Ctrl-P and Ctrl-N are pressed.
set complete=.,t

" Completion Ignored Files -----------------------------------------------

" VCS directories.
set wildignore+=.hg,.git,.svn

" LaTeX intermediate files.
set wildignore+=*.aux,*.out,*.toc

" Binary images.
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

" Lua byte code.
set wildignore+=*.luac

" Compiled object files.
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest

" Python byte code.
set wildignore+=*.pyc

" Compiled spelling lists.
set wildignore+=*.spl

" Backup, auto save, swap, undo, and view files.
set wildignore+=*~,#*#,*.sw?,%*,*=

" Mac OS X.
set wildignore+=*.DS_Store

"set runtimepath+=~/.vim.local
"let $PAGER=''
color solarized
set background=dark

"" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" kill all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
call togglebg#map("<F6>")
let g:solarized_termcolors=16
set t_Co=16

if has ('mouse')
    set mouse=a
    set mousemodel=popup_setpos
    " Hide mouse while typing.
    set mousehide"
    if &term =~ "xterm" || &term =~ "screen"
        set ttymouse=xterm2
    endif
endif

let g:html_indent_inctags = "html,body,hea d,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let g:vimwiki_list = [
            \ {'path': '~/Dropbox/trunksync/notes/ ', 'index': 'HomePage', 'path_html': '~/trunknotes_html', 'ext': '.markdown', 'auto_export': 0}
            \ ]
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let g:extradite_showhash = 1
let g:ctrlp_working_path_mode = 2
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_max_height = 10
let g:ctrlp_persistent_input = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir']
let g:splice_prefix = "<LocalLeader>-"

let g:splice_initial_mode = "grid"

let g:splice_initial_layout_grid = 1
let g:splice_initial_layout_loupe = 0
let g:splice_initial_layout_compare = 0
let g:splice_initial_layout_path = 0

let g:splice_initial_diff_grid = 1
let g:splice_initial_diff_loupe = 0
let g:splice_initial_diff_compare = 0
let g:splice_initial_diff_path = 0

let g:splice_initial_scrollbind_grid = 0
let g:splice_initial_scrollbind_loupe = 0
let g:splice_initial_scrollbind_compare = 0
let g:splice_initial_scrollbind_path = 0

let g:splice_wrap = "nowrap"

let g:syntastic_quiet_warnings = 0

" Do not validate the following file types.
let g:syntastic_disabled_filetypes = ['html', 'python']
"
" Set the display format.
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'



"" AUTOCOMMANDS
au VimResized * exe "normal! \<c-w>="
aug cursorline
    au!
    au BufEnter * set cursorline
    au BufLeave * set nocursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
aug end

