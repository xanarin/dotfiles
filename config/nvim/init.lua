-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- lazy.nvim is initialized at the end so all settings are taken into account
-- when it is loaded


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
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
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

-- Set up reasonable color settings for the nvim-base16 plugin that will be
-- init-ed later
vim.opt.syntax = "enable"
vim.opt.termguicolors = true

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

-- Press SPACE-s-s to toggle spell check
vim.keymap.set('', '<leader>ss', ':setlocal spell!<cr>')

-- Toggle comment
vim.keymap.set('', '<leader>cc', 'gcc<esc>', {remap = true})

-- Move between tabs more easily
vim.keymap.set('', ']t', 'gt')
vim.keymap.set('', '[t', 'gT')

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


-------------------
-- Setup lazy.nvim
-------------------
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
