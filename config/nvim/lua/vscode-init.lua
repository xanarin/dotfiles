-------------------
----- General -----
-------------------
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set SPACE key as leader, following LazyVim convention
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------
-- Mapping
----------
-- Move around windows intelligently -- This doesn't work in VSCode
keymap('', '<C-j>', '<C-W>j')
keymap('', '<C-k>', '<C-W>k')
keymap('', '<C-h>', '<C-W>h')
keymap('', '<C-l>', '<C-W>l')

-- Find files
keymap("n", "<leader>f", "<cmd>lua require('vscode').call('workbench.action.quickOpen')<CR>")
-- Find string in entire repository
keymap("n", "<leader>/", "<cmd>lua require('vscode').call('filesExplorer.findInFolder')<CR>")
-- Open the command palette easily
keymap("n", "<leader>p", "<cmd>lua require('vscode').call('workbench.action.showCommands')<CR>")

-- Spelling shortcuts
keymap("n", "]s", "<cmd>lua require('vscode').action('cSpell.goToNextSpellingIssue')<CR>")
keymap("n", "[s", "<cmd>lua require('vscode').action('cSpell.goToPreviousSpellingIssue')<CR>")
keymap('n', 'yos', function()
  print('Spelling is only available through VSCode and cannot be disabled!')
end)
keymap("n", "zg", "<cmd>lua require('vscode').action('cSpell.addWordToDictionary')<CR>")

-- Jump between differences when in diff view - TODO: These don't work yet
keymap("n", "[d", "<cmd>lua require('vscode').action('multiDiffEditor.goToPreviousChange')<CR>")
keymap("n", "]d", "<cmd>lua require('vscode').action('multiDiffEditor.goToNextChange')<CR>")


--- If we ever remove the vendored vim-unimpaired, we will need to implement the following additional
--  "unimpaired" mappings specific to VScode
-- ]Space - add blank lines after cursor
-- ]e - exchange line with one below it


---------------------------
-- Set up vendored plugins
---------------------------
-- Source the code for each plugin
vim.cmd("source ~/.config/nvim/vendored-plugins/tpope-vim-unimpaired/unimpaired.vim")

-- Add documentation for plugins
vim.cmd("helptags ~/.config/nvim/doc")