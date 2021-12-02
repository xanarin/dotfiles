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

Plugin 'scrooloose/nerdcommenter'
Plugin 'L9'
Plugin 'gcmt/taboo.vim'
Plugin 'junegunn/goyo.vim'
" You complete me - completion
Plugin 'Valloric/YouCompleteMe'
" Color highlighting
Plugin 'chriskempson/base16-vim'
" Syntax Linting
Plugin 'w0rp/ale'
" Simple statusline
Plugin 'itchyny/lightline.vim'
" All of tpope's greatest hits
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
" FZF
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

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

set shiftwidth=4

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set search settings
set ignorecase
set smartcase
set hlsearch
set incsearch

set encoding=utf8

" Use Unix as the standard filetype
set ffs=unix,mac,dos

" Indents
set nocindent " Don't automatically do C-like indenting
set autoindent
set wrap "Wrap lines

" Get persistent undo
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Use the mouse to resize panes
set mouse=a

" Enable folding
set foldmethod=indent
set foldlevel=99

" Preview substitutions in real-time
set inccommand=nosplit

"""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""
" Enable syntax highlighting
syntax enable
syntax on

set t_Co=256
set background=dark

set termguicolors

colorscheme base16-eighties

:hi TabLineFill ctermfg=Blue ctermbg=DarkGray
:hi TabLine ctermfg=LightGray ctermbg=DarkGray
:hi TabLineSel ctermfg=White ctermbg=Blue
:hi Title ctermfg=DarkGray ctermbg=LightGray

" Preserve Transparency on URxvt
hi Normal guibg=NONE ctermbg=NONE

"""""""""""""""""""""
" Moving around
"""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

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

" Move between tabs
map <C-n> :tabn<cr>
map <C-p> :tabp<cr>

"""""""""""""""
" Status line
"""""""""""""""
" Always show the status line
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

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Fast Saving
nmap <leader>w :w!<cr>

" Hard quit
nmap <leader>qq :q!<cr>

" Set soft wrap on
set wrap linebreak nolist

" Set tab width
set tabstop=4
set shiftwidth=4
set expandtab

" Splits
nmap <leader>\ :vsplit<cr>
nmap <leader>- :split<cr>

nmap <C-S>j :res -5<cr>
set splitbelow
set splitright

" Allow local vimrcs
set exrc
set secure

" Preview replacement changes
if has("nvim")
  set inccommand=nosplit
endif


""""""""""""""""""
" Plugin Config
""""""""""""""""""

" ALE (syntax checker)
let g:ale_lint_on_text_changed = 'never'
let g:ale_python_pylint_executable = 'pylint3'
let g:ale_python_pylint_options = '--disable=missing-docstring --max-line-length=200'
let g:ale_python_flake8_options = '--max-line-length 140 --ignore F405,E2,E3,E722'
let g:ale_completion_enabled = 0


" Fuzzy Finding (fzf and rg)
nmap <C-t> :Files<cr>
nmap <C-f> :Rg <C-r><C-w><cr>
" fzf
"nmap <C-F> :execute 'Rg <c-r><c-w>'<cr>
"nmap <C-T> :FZF<cr>

" Goyo
nmap <leader>z :Goyo<cr>

" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\}

" Taboo.vim
map <leader>, :TabooRename

" YouCompleteMe
let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3"
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
map <leader>g :YcmCompleter GoTo<CR>

" Fugitive (Git Wrapper)
" Open diffs in vertical splits
set diffopt+=vertical
nmap gs :Gstatus<cr>

" Python
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=110
    \set expandtab
    \set autoindent
    \set fileformat=unix
"let python_highlight_all=1

" C
au FileType c.doxygen
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set expandtab

" Neovim
tnoremap <Esc> <C-\><C-n>
