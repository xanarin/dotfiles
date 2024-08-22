vim.cmd([[
" Set <LEADER>
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
]])


-------------------
----- General -----
-------------------

-- Set SPACE key as leader, following LazyVim convention
vim.g.mapleader = " "

-- Enable persistent undo file creation, in the default path
vim.opt.undofile = true

-- Remember info about open buffers on close
vim.opt.viminfo:prepend('%')

-- Set search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Set default filetype and encoding
vim.opt.encoding = utf8
vim.opt.ffs = unix,dos,mac

-- Set indentation size and don't allow real tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Configure backspace so it acts as it should act
vim.opt.whichwrap:append({
    ["<"] = true,
    [">"] = true,
    ["h"] = true,
    ["l"] = true,
})

-- Enable folding
vim.opt.foldmethod = indent
vim.opt.foldlevel = 99

-- Make display-only linebreaks nicer
vim.opt.linebreak = true

-- Keep hidden characters hidden
vim.opt.list = false

-- Split in reasonable ways
vim.opt.splitbelow = true
vim.opt.splitright = true


vim.cmd([[
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
]])

----------
-- Mapping
----------
-- Treat long lines as break lines
vim.keymap.set('', 'j', 'gj')
vim.keymap.set('', 'k', 'gk')

-- Move around windows intelligently
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- Move between tabs
vim.keymap.set('', ']t', ':tabn<cr>')
vim.keymap.set('', '[t', ':tabp<cr>')

-- Press SPACE-s-s to toggle spell check
vim.keymap.set('', '<leader>ss', ':setlocal spell!<cr>')

---------
-- Events
---------
-- (From vim defaults.vim)
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
    local not_commit = vim.b[args.buf].filetype ~= 'commit'

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-----------------
-- Plugin Configs
-----------------
-- Fuzzy finding
vim.keymap.set('n', '<leader>f', ':Files<cr>')
vim.keymap.set('n', '<leader>/', ':Rg <C-r><C-w><cr>')

-- Goyo (focus mode)
vim.keymap.set('n', '<leader>z', ':Goyo<cr>')

-- Taboo (modify tabs easily)
vim.keymap.set('n', '<leader>tr', ':TabooRename ')

-- Fugitive (Git Wrapper)
vim.keymap.set('n', '<leader>gs', ':Git<cr>')
vim.keymap.set('n', '<leader>gb', ':Git blame<cr>')
-- Open diffs in vertical splits
vim.opt.viminfo:append({vertical})


vim.cmd([[
""""""""""""""""""
" Plugin Config
""""""""""""""""""
" ALE (syntax checker)
let g:ale_lint_on_text_changed = 'never'
let g:ale_python_pylint_options = '--disable=missing-docstring,invalid-name --max-line-length=200'
let g:ale_python_flake8_options = '--max-line-length 140 --ignore F405,E2,E3,E722'
let g:ale_completion_enabled = 0


" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\}

" Neovim
tnoremap <Esc> <C-\><C-n>
]])
