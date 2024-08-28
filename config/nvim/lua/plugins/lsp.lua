return {
  {
    "lsp-zero.nvim",
    branch = "v4.x",
    url = "https://github.com/VonHeikemen/lsp-zero.nvim",
    lazy = true,
    config = false,
  },

  -- Autocompletion
  {
    "nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp",
    event = 'InsertEnter',
    dependencies = {
      {'LuaSnip', url = "https://github.com/L3MON4D3/LuaSnip"},
      {'cmp-path', url = "https://github.com/hrsh7th/cmp-path"},
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
          {name = 'path'},
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    "nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig",
    cmd = 'LspInfo',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {"cmp-nvim-lsp", url = "https://github.com/hrsh7th/cmp-nvim-lsp"},
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        local opts = {buffer = bufnr}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      -- TODO: Add more language servers as they are installed on the system
      require('lspconfig').gopls.setup({})
      require('lspconfig').pylsp.setup({})
    end
  },
}
