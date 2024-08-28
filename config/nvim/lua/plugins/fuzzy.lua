return {
  {
    "fzf",
    -- Pinning version to keep compatability with older fzf in Debian 12
    version = "0.38.0",
    url = "https://github.com/junegunn/fzf",
    lazy = false, -- We need this from the very beginning
  },
  {
    name="fzf.vim",
    -- Pinning version to keep compatability with older fzf in Debian 12
    commit = "04bfa8115716",
    url = "https://github.com/junegunn/fzf.vim",
    lazy = false, -- We need this early on
    config = function()
        vim.keymap.set('n', '<leader>f', ':Files<cr>')
        vim.keymap.set('n', '<leader>/', ':Rg <C-r><C-w><cr>')
    end,

  }
}
