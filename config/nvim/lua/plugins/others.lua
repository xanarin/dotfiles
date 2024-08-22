return {
  {'romgrk/barbar.nvim',
    url = 'https://github.com/romgrk/barbar.nvim.git',
    dependencies = {
      {'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
       url = 'https://github.com/nvim-tree/nvim-web-devicons',
      },
    },
    init = function()
      vim.g.barbar_auto_setup = false
      -- Move between tabs
      vim.keymap.set('', ']b', ':BufferNext<cr>')
      vim.keymap.set('', '[b', ':BufferPrevious<cr>')
      vim.keymap.set('', '<leader>bc', ':BufferClose<cr>')
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      --hide = {inactive = true},
      auto_hide = 1,
      animation = false,
      insert_at_end = true,
      -- …etc.
    },
  },
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
