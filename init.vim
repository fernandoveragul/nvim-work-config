:filetype plugin indent on

:set autoindent
:set number            " numeric strings
:set ewncoding=utf-8   " encoding mode (nvim default <utf-8>)
:set noswapfile        " don't create chache file <.swp>

:set tabstop=4         " settings <TAB> for CPython
:set shiftwidth=4      " settings <TAB> for CPython
:set smarttab          " settings <TAB> for CPython
:set softtabstop=4     " settings <TAB> for CPython
:set expandtab         " settings <TAB> for CPython

:set mouse=a           " enable mouse control

call plug#begin()      " start block with pluggins

" for install pluggins use mask 
" <Plug 'https://github.com/username/packagename'>

Plug 'https://github.com/nvim-neo-tree/neo-tree.nvim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'https://github.com/akinsho/bufferline.nvim', {'tag', 'v3.*}
Plug 'https://github.com/jose-elias-alvarez/null-ls.nvim'
Plug 'https://github.com/nvim-tree/nvim-web-devicons'
Plug 'https://github.com/rafi/awesome-vim-colorscheme'
" Plug 'https://github.com/nvim-treesitter/nvim-treesitter'

Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'https://github.com/hrsh7th/cmp-buffer'
Plug 'https://github.com/hrsh7th/cmp-path'
Plug 'https://github.com/hrsh7th/cmp-cmdline'
Plug 'https://github.com/hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'https://github.com/hrsh7th/cmp-vsnip'
Plug 'https://github.com/hrsh7th/vim-vsnip'

call plug#end()        " end block with pluggins

:nnoremap <C-t,t> :NERDTreeToggle <CR>
:nnoremap <C-\> :TagbarToggle <CR>
:nnoremap <C-t> :ToggleTerm <CR>
:nnoremap <C-t,c> :ToggleTermToggleAll size=20 <CR>

:let g:tagbar_compact=1
:let g:tagbar_sort=0
":let 

:set colorscheme onedark

:set completeopt=menu,menuone,noselect

lua <<EOF
  -- Set up nvim-cmp.
  require('bufferline').setup{}
  require('toggleterm').setup{}
  require('nvim-tree').setup{}
  
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
EOF

