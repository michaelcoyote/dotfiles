" vimrc for most things
" mostly targets 7.0 or later and is not vi compatable
" This may not work for you. I like weird fonts
" have an a taste for obscure options and try odd things
" I also work on a lot of different platforms
" No warranty is implied, use at your own risk.


" see, I told you..  
set nocompatible

" turn off the splash screen
set shortmess+=I

" Vim keymapping +++++++++++++++++++++++++++++++++++++++++++++++
" Set up the leader and localleader here in case I want it below
" With a leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "-"
let g:maplocalleader = "-"

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" save a file fast.
nmap <Leader>w :w!<cr>
" quit a file fast 
nmap <Leader>q :wq!<cr>

" ++++++++++++++++++++++++++++++++++++++++++++++++++++ 
" set up the generic GUI options
if has('gui_running')
	" set up a decent default size 
	set lines=27 columns=88
    " remove tearoffs
    set guioptions-=T
    " add tab pages
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    " useful window resize commands
    nmap <leader>ws :set lines=27 columns=88<cr>
    nmap <leader>wm :set lines=40 columns=132<cr>
    nmap <leader>wl :set lines=45 columns=160<cr>
	" Per OS/GUI options ++++++++++++++++++++++++++
	" Set up fonts and other items on a GUI by GUI basis...
	if has('gui_win32')
		" I like the "peep" font - http://zevv.nl/play/code/zevv-peep/
		set guifont=peep:h11,Consolas:h11
	endif
	if has('gui_macvim')
        echo "looks like we're using macvim"
		" Monaco 10 pt looks good, 
		set guifont=Monaco:h10
	endif

endif

" Useful mapped commands
"
" toggle line numbers
nnoremap <Leader>n :set invnumber<cr>
" toggle syntax (when it bogs down vim)
function! SynToggle()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction
nnoremap <leader>s :call SynToggle()<cr>
" toggle 80 column bar
function! EightyColumnBar()
    if &colorcolumn == 0
        setlocal colorcolumn=80
    else
        setlocal colorcolumn=0
    endif
endfunction
nnoremap <leader>b :call EightyColumnBar()<cr>
" toggle paste mode
nnoremap <leader>p :set paste!<cr>
" quick edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" quicksource vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" set fast terms and mouse modes for local terms
"if &term =~ 'linux'|'xterm'|'rvxt'
"	set ttyfast
"	set mouse=a
"endif

" Vim key behaviour +++++++++++++++++++++++++++++++++++++++++++  
" Use spaces instead of tabs
set expandtab
" does the right thing on tabs and backspaces
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" set some sane backspace behavior
set backspace=indent,eol,start
" Set 2 spaces after punctuation w/ a join line command
set joinspaces
" do not move cursor to 1st non blank of line on command
set nostartofline
" Time spent waiting for a ctrl key/sequence to complete in ms
set timeoutlen=500


" Vim textual color behaviour ++++++++++++++++++++++++++++++++
" color scheme - I love me some elflord
colorscheme elflord
" turn on syntax highlighting
syntax enable
" Enable filetype detection w/ plugins & smart indenting
filetype on
filetype plugin on
filetype indent on

" Set up autocommands for various file types
"
" Make sure context highlighting works for *.md markdown files
"  this overrides the typical behavior of highlighting Modula-2
au BufRead,BufNewFile *.md set filetype=markdown shiftwidth=2 tabstop=2

" Vim Spellchecker +++++++++++++++++++++++++++++++++++++++++++
" turn on spellcheck if version 7 or above
if v:version >= 700
    " Enable spell check for text files
    autocmd BufNewFile,BufRead *.{txt,md} setlocal spell spelllang=en
    " Pressing ,ss will toggle and untoggle spell checking
    map <Leader>ss :setlocal spell!<cr>
    " Shortcuts using <leader>
    map <Leader>sn ]s
    map <Leader>sp [s
    map <Leader>sa zg
    map <Leader>s? z=
endif

" Vim search ++++++++++++++++++++++++++++++++++++++++++++++++++
" do useful search things
if has('extra_search')
	" Highlight results and match while typing search string. 
	set incsearch hlsearch
endif
" Use case insensitive search, except when using capital letters
set ignorecase smartcase
" Press space to clear search highlighting and any message already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" Vim file handling +++++++++++++++++++++++++++++++++++++++++
" do not create a backup before writing a file
set nobackup
" make a backup before overwriting a file
set writebackup
" Set to auto read when a file is changed from the outside
set autoread

" Vim UI +++++++++++++++++++++++++++++++++++++++++++++++++++++
" always show current position in the statusbar
set ruler
" Height of the command bar
set cmdheight=2
" No annoying sound or flashing on errors
set noerrorbells novisualbell
" unset termcap visual bell 
set t_vb=
" I like to keep a lot of Vim history.
set history=700
" a mouse for all modes
set mouse=a
" this is a fast terminal
set ttyfast
"
" Run pathogen if it exists in the correct place.
if filereadable(expand("~/.vim/autoload/pathogen.vim"))
    execute pathogen#infect()
    " echomsg "Pathogen enabled"
else
    echomsg "Pathogen not found"
endif
