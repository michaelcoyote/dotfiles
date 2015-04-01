" vimrc for most things
" mostly targets 7.0 or later and is not vi compatable
" This may not work for you. I like weird fonts
" have an a taste for obscure options and try odd things
" I also work on a lot of different platforms
" No warranty is implied, use at your own risk.


" see, I told you..  
set nocompatible

" Set up the mapleader here in case I want it below
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" For example, saving a file fast.
nmap <Leader>w :w!<cr>
" 

" ++++++++++++++++++++++++++++++++++++++++++++++++++++ 
" set up the generic GUI options
if has('gui_running')
	" set up a decent default size 
	set lines=45 columns=160
    " remove tearoffs
    set guioptions-=T
    " add tab pages
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
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

" Vim keymapping +++++++++++++++++++++++++++++++++++++++++++++++
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" 

" Vim textual color behaviour ++++++++++++++++++++++++++++++++
" color scheme - I love me some elflord
colorscheme elflord
" turn on syntax highlighting
syntax enable
" Enable filetype detection w/ plugins & smart indenting
filetype on
filetype plugin on
filetype indent on
" Make sure context highlighting works for *.md markdown files
"  this overrides the typical behavior of highlighting Modula-2
au BufRead,BufNewFile *.md set filetype=markdown

" Vim Spellchecker +++++++++++++++++++++++++++++++++++++++++++
" turn on spellcheck if version 7 or above
if v:version >= 700
    " Enable spell check for text files
    autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
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
    echo "Pathogen enabled"
else
    echo "Pathogen not found"
endif
