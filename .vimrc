" Set <LEADER>
let mapleader = ","

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Buffer explorer import
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'scrooloose/syntastic'
Plugin 'Shutnik/jshint2.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'burnettk/vim-angular'
Plugin 'L9'
Plugin 'vim-scripts/FuzzyFinder'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" Put your non-Plugin stuff after this line

" ####################
" BEGIN CUSTOM CONFIGS
" ####################

"""""""""""""""""""
" General
"""""""""""""""""""
" Turn persistent undo on.
" Means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

set shiftwidth=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set search settings
set ignorecase
set smartcase
set hlsearch
set incsearch

"""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme desert

set encoding=utf8

" Use Unix as the standard filetype
set ffs=unix,mac,dos

" Indents
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""
" Moving around
"""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

" Map <Space> to / (search)
map <space> /

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Move around windows intelligently
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

"""""""""""""""
" Status line
"""""""""""""""
" Always show the status line
set laststatus=2

" Function to show word count
function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos('.')
  exe ':silent normal g\<c-g>'
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    let s:word_count = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count
endfunction


" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" first, enable status line always
set laststatus=2

""""""""""""""""""
" Spell Checking
""""""""""""""""""
" Press ,ss to toggle spell check
map <leader>ss :setlocal spell!<cr>

"Shortcuts to move around spell check
map <leader>sn ]s
map <leader>sp [s
map <leader>s? z=

""""""""""""""""""
" Misc Mappings
""""""""""""""""""
" Quickly open a buffer for scribble
map <leader>` :split ~/buffer<cr>

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Fast Saving
nmap <leader>w :w!<cr>

" Add closing curly bracket
inoremap { {<CR><BS><BS>}<Esc>ko

" Hard quit
nmap <leader>qq :q!<cr>

" Set soft wrap on
set wrap linebreak nolist

" Set tab width
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Run Make
nmap <leader>m :make!<cr>

" Run test program
nmap <leader>rt :!sh ./run.sh<cr>

" Run node on current script
nmap <leader>ns :! node %<cr>

" Map build and install for Pebbble Dev
nmap <leader>pb :! pebble build && pebble install --emulator basalt <cr>
nmap <leader>pa :! pebble build && pebble install --emulator aplite <cr>

""""""""""""""""""
" Plugin Config
""""""""""""""""""

" bufExplorer plugin
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='mru'
map <leader>o :BufExplorer<cr>

" NerdTREE plugin
map <leader>nn :NERDTreeToggle<cr>

" VimAirline plugin
let g:airline_theme='sol'
let g:airline_powerline_fonts = 1

" Syntastic plugin
let g:syntastic_c_check_header = 1

" Fuzzy Finder
nmap <leader>f :FufFile<cr>

" Fugitive (Git Wrapper)
nmap <leader>gs :Gstatus<cr>
