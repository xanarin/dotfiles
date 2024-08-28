return {
  {"nvim-base16",
    url = "https://github.com/RRethy/base16-nvim",
    lazy = false, -- We need this from the very beginning
    priority = 1000,
    config = function()
        -- set the colorscheme
        vim.cmd('colorscheme base16-eighties')
    end,
  },
  {"lightline",
    url = "https://github.com/itchyny/lightline.vim",
    lazy = false, -- We need this early on
    priority = 900,
    config = function()
        -- set the desired color theme
        vim.g.lightline = { ['colorscheme'] = 'wombat' }
    end,
  }
}
