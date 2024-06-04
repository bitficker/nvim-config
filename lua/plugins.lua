require('packer').startup(function(use)
		
	-- packer can manage itself
	use 'wbthomason/packer.nvim'
	
	-- dependencies
	use {	
		'williamboman/mason-lspconfig.nvim',
		'williamboman/mason.nvim',
		run = ":MasonUpdate", -- :MasonUpdate updated registry contents

		'neovim/nvim-lspconfig',
	}
	
	use {
		'mrcjkb/haskell-tools.nvim',
		version = '^3', -- Recommended
		lazy = false, -- This plugin is already lazy
	}

	-- alpha-vim
	use {
    		'goolord/alpha-nvim',
    		requires = {
        		'nvim-tree/nvim-web-devicons',
        		'nvim-lua/plenary.nvim'
    		},
    		config = function ()
        		require'alpha'.setup(require'alpha.themes.dashboard'.config)
    		end
	}

	
	-- nvim-cmp
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'

	use 'airblade/vim-gitgutter'

	use 'nvim-lualine/lualine.nvim'
	
	use 'mg979/vim-visual-multi'

	use 'nvim-tree/nvim-tree.lua'
	
	use {
  		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		-- or                            , branch = '0.1.x',
  		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	use 'mfussenegger/nvim-dap'

end)


require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "omnisharp" }
}
require('lualine').setup()
require('nvim-tree').setup {
	view = {
		side = 'right',
	}
}
require('telescope').load_extension('fzf')

local lspconfig = require('lspconfig')
lspconfig.omnisharp.setup{}

local dap = require('dap')
dap.adapters.csharp = {
	type = 'executable';
	command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin';
	args = { -m, 'netcoredbg.adapter' }
}

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
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
	{ name = 'path' },
	{ name = 'nvim_lsp', keyword_length = 3 },
	{ name = 'nvim_lsp_signature_help' },
	{ name = 'nvim_lua', keyword_length = 2 },
	{ name = 'buffer', keyword_length = 2 },
	{ name = 'vsnip', keyword_length = 2 }
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
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
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

