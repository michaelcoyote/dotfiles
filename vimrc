" vimrc for most things
" Disclaimer
" targets 7.0 or later and is not vi compatable
" This may not work for you. I like weird fonts
" have an a taste for obscure options and try odd things
" I also work on a lot of different platforms
" No warranty is implied, use at your own risk.

" turn off the splash screen
set shortmess+=I

" Vim keymapping +++++++++++++++++++++++++++++++++++++++++++++++
" Set up the leader and localleader here in case I want it below
" With a leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ','
let g:mapleader = ','
let maplocalleader = '-'
let g:maplocalleader = '-'

" +++ Useful mapped commands +++
" toggle line numbers
nnoremap <leader>N :set invnumber<cr>
" toggle syntax (when it bogs down vim)
function! SynToggle()
    if exists('g:syntax_on')
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
" toggle red bar at 80 col
nnoremap <leader>! :call EightyColumnBar()<cr>
" toggle paste mode
nnoremap <leader>p :set paste!<cr>
" quick edit vimrc
nnoremap <leader>ve :vsplit $HOME/.dotfiles/vimrc<cr>
" quicksource vimrc
nnoremap <leader>vs :source $HOME/.dotfiles/vimrc<cr>
" split navigation with ctl-HJKL
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" save all open buffers fast.
nnoremap <leader>w :wa!<cr>
" save and quit all open buffers fast 
nnoremap <leader>Q :wq!<cr>

" Vim key behaviour +++++++++++++++++++++++++++++++++++++++++++  
" Time spent waiting for a ctrl key/sequence to complete in ms
set timeoutlen=500
" Set 2 spaces after punctuation w/ a join line command
set joinspaces
" do not move cursor to 1st non blank of line on command
set nostartofline
" set some sane backspace behavior
set backspace=indent,eol,start
" does the right thing on tabs and backspaces
set smarttab
" Use spaces instead of tabs
set expandtab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Vim UI +++++++++++++++++++++++++++++++++++++++++++++++++++++
" +++ Set up UI options +++
" always show current position in the statusbar
set ruler
" Height of the command bar
set cmdheight=2
" always see status bar
set laststatus=2
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
" +++ Set up GUI options +++
if has('gui_running')
	" set up a decent default size 
	set lines=40 columns=132
    " remove tearoffs
    set guioptions-=T
    " add tab pages
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    " enable mouse searching
    set mousemodel=extend
    " useful window resize commands
    nnoremap <leader>ws :set lines=27 columns=88<cr>
    nnoremap <leader>wm :set lines=40 columns=132<cr>
    nnoremap <leader>wl :set lines=45 columns=164<cr>
    nnoremap <leader>wx :set lines=65 columns=164<cr>
    nnoremap <leader>ww :set lines=75 columns=246<cr>
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

" +++ Turn on version 7 or above features +++
if v:version >= 700
    " Vim Spellchecker
    " Enable spell check for text files
    autocmd BufNewFile,BufRead *.{txt,md} setlocal spell spelllang=en
    " Pressing ,zz will toggle and untoggle spell checking
    noremap <leader>zz :setlocal spell!<cr>
    " Shortcuts using <leader>
    noremap <leader>zn ]s
    noremap <leader>zp [s
endif

" Vim textual color behaviour ++++++++++++++++++++++++++++++++
" color scheme - I love me some elflord
colorscheme elflord
" turn on syntax highlighting
syntax enable
" Enable filetype detection w/ plugins & smart indenting
filetype on
filetype plugin on
filetype indent on

" Vim search ++++++++++++++++++++++++++++++++++++++++++++++++++
" do useful search things
if has('extra_search')
	" Highlight results and match while typing search string. 
	set incsearch hlsearch
endif
" Use case insensitive search, except when using capital letters
set ignorecase smartcase
" Press space to clear search highlighting and any message
" already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" Vim file handling +++++++++++++++++++++++++++++++++++++++++
" do not create a backup before writing a file
set nobackup
" make a backup before overwriting a file
" set writebackup
" Set to auto read when a file is changed from the outside
set autoread
" Set up autocommands for various file types
"
" Make sure context highlighting works for *.md markdown files
"  this overrides the typical behavior of highlighting Modula-2
au BufRead,BufNewFile *.md set filetype=markdown shiftwidth=2 tabstop=2
" Python and shell
au BufRead,BufNewFile *.{py,pyw,sh,bash}
            \ set tabstop=4 softtabstop=4 shiftwidth=4 |
            \ set textwidth=79 expandtab autoindent |
            \ set fileformat=unix number
au BufRead,BufNewFile *.{js,html,cs}
            \ set tabstop=2 softtabstop=2 shiftwidth=2 |
            \ set number

" Handy things to have for coding & etc. +++++++++++++++++++++
" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <Leader>f za
" highlight bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.{py,pyw,c,h,sh} match BadWhitespace /\s\+$/
" ctags for the usual projects
nnoremap <Leader>T :!ctags -R -o $HOME/.tags/rkpythonscripts $HOME/sdmain;
            \ ctags -R -o $HOME/.tags/rkpython $HOME/sdmain/src/py <CR>
set tags+=$HOME/.tags/rkpythonscripts
set tags+=$HOME/.tags/rkpython
" insert a datestamp
nnoremap <leader>ts :put = strftime('%FT%T%z')<cr>
nnoremap <leader>ds :put = strftime('%F')<cr>


" Run pathogen if it exists in the correct place.
if filereadable(expand('~/.vim/autoload/pathogen.vim'))
    execute pathogen#infect()
else
    echomsg 'Pathogen not found'
endif
" fugitive
if isdirectory(expand('~/.vim/bundle/vim-fugitive/'))
    noremap gb :Gblame
    noremap gl :Glog
    noremap ge :Gedit
    noremap gd :Gdiff
endif
