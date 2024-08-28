return {
  {'tpope/vim-fugitive',
    url = 'https://github.com/tpope/vim-fugitive.git',
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<cr>')
      vim.keymap.set('n', '<leader>gb', ':Git blame<cr>')
      -- Open diffs in vertical splits
      vim.opt.viminfo:append({vertical})
    end,
  },
  {'tpope/vim-unimpaired',
    url = 'https://github.com/tpope/vim-unimpaired',
  },
}
