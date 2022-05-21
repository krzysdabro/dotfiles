local use = require('packer').use


return require('packer').startup({function()
  use { 'wbthomason/packer.nvim' }
  use { 'folke/tokyonight.nvim' }
  use { 'tpope/vim-fugitive' }
  use { 'sheerun/vim-polyglot' }

  use {
    'airblade/vim-gitgutter',
    config = function()
      vim.opt.signcolumn = 'yes'
      vim.opt.updatetime = 100

      vim.cmd('autocmd BufEnter,BufWritePost * GitGutter')
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      vim.g.nvim_tree_quit_on_open = 1
      vim.g.nvim_tree_indent_markers = 1

      vim.g.nvim_tree_show_icons = {
        git = 0,
        folders = 0,
        files = 0,
        folder_arrows = 0
      }

      require('nvim-tree').setup {
        open_on_setup = true,
        auto_close = true,
        filters = {
          custom = { '.git', 'node_modules', '.cache', '__pycache__', '.DS_Store' }
        },
        update_focused_file = {
          enable = true
        },
        git = {
          enable = false
        },
        view = {
          side = 'left',
          width = 50
        }
      }
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'NvimTree' },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'filename', file_status = false }
          },
          lualine_c = {},
          lualine_x = { 'branch', 'fileformat', 'encoding', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        }
      }
    end
  }

end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
