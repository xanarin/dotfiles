return {
  {
    "fzf",
    url = "https://github.com/junegunn/fzf",
    lazy = false, -- We need this from the very beginning
  },
  {
    name="fzf.vim",
    url = "https://github.com/junegunn/fzf.vim",
    lazy = false, -- We need this early on
    config = function()
        vim.keymap.set('n', '<leader>f', ':Files<cr>')
        vim.keymap.set('n', '<leader>/', ':Rg <C-r><C-w><cr>')
    end,

  }
}
