" vimrc for most things
" Disclaimer
" targets 7.0 or later and is not vi compatable
" This may not work for you. I like weird fonts
" have an a taste for obscure options and try odd things
" I also work on a lot of different platforms
" No warranty is implied, use at your own risk.

" turn off the splash screen
set shortmess+=I

set encoding=utf-8
scriptencoding utf-8

" Vim completion +++++++++++++++++++++++++++++++++++++++++++++++
" Set up some useful defaults for vim insert completion
" Set spelling dictionary but only when file in "spell" mode
set complete+=k

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
nnoremap <leader>n :set invnumber<cr>
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
" toggle set list
nmap <leader>l :set list!<cr>

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
" set term color to 256 (but may fail)
set t_Co=256
" +++ Set up GUI options +++
if has('gui_running')
    " set up a decent default size
    set lines=65 columns=164
    " remove tearoffs
    set guioptions-=T
    " add tab pages
    set guioptions+=e
    set guitablabel=%M\ %t
    " enable mouse searching
    set mousemodel=extend
    " useful window resize commands
    nnoremap <leader>ws :set lines=27 columns=88<cr>
    nnoremap <leader>wm :set lines=40 columns=132<cr>
    nnoremap <leader>wl :set lines=45 columns=164<cr>
    nnoremap <leader>wx :set lines=65 columns=164<cr>
    nnoremap <leader>ww :set lines=75 columns=320<cr>
    " support larged fenced codeblocks in markdown
    let g:markdown_minlines = 400
    " Per OS/GUI options ++++++++++++++++++++++++++
    " Set up fonts and other items on a GUI by GUI basis...
    if has('gui_win32')
        " I like the peep font - http://zevv.nl/play/code/zevv-peep/
        " but it turns out Iosevka is more avalible
        set guifont=Iosevka:h11,Consolas:h11
    elseif has('gui_macvim')
        echo "looks like we're using macvim"
        " Monaco 10 pt looks good, if I don't have Hack or Iosevka 
        set guifont=Iosevka:h11,Hack:h12,Monaco:h10
    elseif has('gui_gtk2') || has('gui_gtk3')
        " echo "using gtk"
        set guifont=Iosevka\ 11,Monospace\ 11
    elseif has('x11')
        echo "base X11"
        set guifont=*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    else
        set guifont=Courier_New:h11:cDEFAULT
    endif
endif

" +++ Turn on version 7 or above features +++
if v:version >= 700
    " Vim Spellchecker
    " Enable spell check for text files
    augroup spell
        autocmd BufNewFile,BufRead *.{txt,md} setlocal spell spelllang=en
    augroup END
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
augroup tabsettings
    " Make sure context highlighting works for *.md markdown files
    "  this overrides the typical behavior of highlighting Modula-2
    au BufRead,BufNewFile *.md set filetype=markdown shiftwidth=2 tabstop=2
    " Python and shell
    au BufRead,BufNewFile *.{py,pyw,sh,bash}
                \ set tabstop=4 softtabstop=4 shiftwidth=4 |
                \ set textwidth=79 expandtab autoindent |
                \ set fileformat=unix number
    au BufRead,BufNewFile *.{js,html,css,yaml}
                \ set tabstop=2 softtabstop=2 shiftwidth=2 |
                \ set textwidth=79 autoindent number
    au BufNewFile,BufRead *.go
                \ set tabstop=4 shiftwidth=4 softtabstop=4 |
                \ set textwidth=79 noexpandtab autoindent |
                \ set number
    au BufNewFile,BufRead *.tsx set filetype=typescript
    " workaround to get todo working 
    au BufNewFile,BufRead $HOME/Dropbox/todo/todo.txt set filetype=todo
    au BufRead,BufNewFile todo.txt set filetype=todo
augroup END
" Code block syntax highlighting for markdown
let g:markdown_fenced_languages = ['html', 'python', 'c',
            \ 'bash=sh', 'sh', 'js=javascript',
            \ 'JSON=javascript', 'json=javascript',
            \ 'sql', 'css', 'xml']
" Handy things to have for coding & etc. +++++++++++++++++++++
" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <Leader>f za
" highlight bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
augroup badwhitespace
    au BufRead,BufNewFile *.{go,py,pyw,c,h,sh,js,rs} match BadWhitespace /\s\+$/
augroup END
" setup nice ALE indicators
let g:ale_sign_error = '◉>'
let g:ale_sign_warning = '◉-'
highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#F5F5F5
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#F5F5F5
" ctags for the usual projects
nnoremap <Leader>T :!ctags -R -o $HOME/.tags/rkpythonscripts $HOME/work;
            \ ctags -R -o $HOME/.tags/rkpython $HOME/work <CR>
set tags+=$HOME/.tags/rkpythonscripts
set tags+=$HOME/.tags/rkpython
" insert a datestamp
nnoremap <leader>ts "=strftime('%FT%T%z ')<cr>P
nnoremap <leader>ds "=strftime('%F ')<cr>P


" Run pathogen if it exists in the correct place.
if filereadable(expand('~/.vim/autoload/pathogen.vim'))
    execute pathogen#infect()
else
    echomsg 'Pathogen not found'
endif
" fugitive
if isdirectory(expand('~/.vim/bundle/vim-fugitive/'))
    noremap gb :Gblame<cr>
    noremap gl :Glog<cr>
    noremap ge :Gedit<cr>
    noremap gd :Gdiff<cr>
    noremap gw :Gwrite<cr>
    noremap gc :Gcommit<cr>
endif
