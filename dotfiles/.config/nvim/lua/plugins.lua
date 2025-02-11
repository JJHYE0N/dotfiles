local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/start/packer.nvim'
local is_packer_not_installed = vim.fn.empty(vim.fn.glob(install_path)) > 0
if is_packer_not_installed then
  vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer = require('packer')
packer.init({max_jobs = 4})

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Vim basic utility
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-fugitive'}
  use {'raimondi/delimitmate'}
  use {'mbbill/undotree'}
  -- Development Utilities (Neovim 5.0+)
  use {'neovim/nvim-lspconfig'}
  -- non-LSP sources to hook into its LSP client
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require("config.null-ls")
    end
  }
  use {'nvim-lua/plenary.nvim'}
  use {'nvim-lua/popup.nvim'}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function()
      require("config.tree-sitter")
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    config = function()
      require("config.telescope")
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require("config.gitsigns")
    end
  }
  use {
    'sbdchd/neoformat',
    config = function()
      require("config.neoformat")
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require("config.nvim-tree")
    end
  }
  use {
    'liuchengxu/vista.vim',
    config = function()
      require("config.vista")
    end
  }
  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require("config.toggleterm")
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require("Comment").setup()
    end
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'rcarriga/cmp-dap'
    },
    config = function()
      require("config.cmp")
    end
  }
  use {
    'SirVer/ultisnips',
    requires = {'quangnguyen30192/cmp-nvim-ultisnips'},
    config = function()
      require("config.ultisnips")
    end
  }

  -- clangd extension
  use {'p00f/clangd_extensions.nvim'}

  -- rust extension
  use {'simrat39/rust-tools.nvim'}

  -- python extension
  use {'numirias/semshi'}

  -- nvim api
  use {"folke/neodev.nvim"}

  -- test adopter
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python"
      -- "antoinemadec/FixCursorHold.nvim"
    },
    config = function()
      require("config.neotest")
    end
  }

  -- DAP
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require("config.dap")
    end
  }
  use {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('python')
      -- require('dap-python').resolve_python = function()
      --   return '/absolute/path/to/python'
      -- end
    end
  }
  use {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('config.dapui')
    end
  }
  use {'nvim-telescope/telescope-dap.nvim'}

  -- js/css
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('config.nvim-colorizer')
    end
  }

  -- Look & Feel
  use {'kyazdani42/nvim-web-devicons'}
  use {'folke/lsp-colors.nvim'}
  use {
    'folke/todo-comments.nvim',
    config = function()
      require("config.todo")
    end
  }
  use {
    'onsails/lspkind-nvim',
    config = function()
      require("config.lspkind")
    end
  }
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require("config.bufferline")
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require("config.lualine")
    end
  }
  use {
    'monsonjeremy/onedark.nvim',
    config = function()
      require("config.onedark")
    end
  }
  use {
    'mhinz/vim-startify',
    config = function()
      require("config.startify")
    end
  }

  -- Post-install/update hook with call of vimscript function with argument
  use {
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end
  }

  if is_packer_not_installed then
    require('packer').sync()
  end
end)

