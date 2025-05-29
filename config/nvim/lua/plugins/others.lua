return {
  -- Great git interfacing
  {'tpope/vim-fugitive',
    url = 'https://github.com/tpope/vim-fugitive',
    config = function()
      -- Open diffs in vertical splits
      vim.opt.viminfo:append({vertical})
    end,
    keys = {
      { "<leader>gs", ':Git<cr>', desc = "Git Status", mode = { "n", "v" } },
      { "<leader>gb", ':Git blame<cr>', desc = "Git blame", mode = { "n", "v" } },
      { "<leader>gD", ':Gvdiff<cr>', desc = "Git diff - vertical", mode = { "n", "v" } },
    },
  },
  -- Better movement keybindings
  {'tpope/vim-unimpaired',
    url = 'https://github.com/tpope/vim-unimpaired',
  },
  -- General utilities
  {'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    --@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      gitbrowse = {
        enabled = true,
        config = function(opts, defaults)
          -- Set up custom URL handling for self-hosted GitLab. The % character
          -- escapes out the following character from the regex engine
          opts.url_patterns["gitlab%.self%-hosted%.com"] = opts.url_patterns["gitlab%.com"]
          -- Don't prompt and block when opening
          opts.notify = false
        end
      },
      quickfile = { enabled = true },
    },
    keys = {
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    },
  },
  -- Time to really learn Vim and break bad habits
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
}
