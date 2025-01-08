-- 🐣

-- Auto-open NvimTree when opening Neovim
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    require('nvim-tree.api').tree.open()
  end,
})

-- Plugin configuration for lazy.nvim
return {
  -- nvim-web-devicons for file icons
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup { default = true }
    end,
  },

  -- nvim-tree file explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = {
          width = 30,
        },
      }

      -- Keybinding to toggle the file explorer
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
    end,
  },

  -- toggleterm for terminal management
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = '<leader>t',
        size = 20,
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = false, -- Changed this to false to prevent insert mode triggering
        persist_mode = true,
        shell = vim.o.shell,
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
      }
      -- Enter insert mode when clicking into a terminal window
      vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
        pattern = 'term://*',
        callback = function()
          vim.cmd 'startinsert'
        end,
      })
      -- Map <Esc> to enter normal mode in terminal buffers
      vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = 'Exit terminal mode' })
      -- Additional keybindings for opening terminals
      vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical size=50<CR>', { noremap = true, silent = true, desc = 'Open vertical terminal' })
      vim.keymap.set(
        'n',
        '<leader>tb',
        '<cmd>ToggleTerm direction=horizontal size=20<CR>',
        { noremap = true, silent = true, desc = 'Open horizontal terminal' }
      )
    end,
  },

  -- plenary for utility functions
  { 'nvim-lua/plenary.nvim' },

  -- lazygit integration
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'Open LazyGit' },
    },
  },

  -- lualine statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
      }
    end,
  },

  -- material.nvim theme
  {
    'marko-cerovac/material.nvim',
    priority = 1000, -- Load the theme early
    config = function()
      -- Set the material theme style
      vim.g.material_style = 'deep ocean' -- Options: "darker", "lighter", "palenight", "deep ocean"

      -- Load the colorscheme
      vim.cmd.colorscheme 'material'
    end,
  },

  -- bufferline for file tabs
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup {
        options = {
          numbers = 'buffer_id',
          diagnostics = 'nvim_lsp',
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          separator_style = 'slant',
          always_show_bufferline = true,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
              text_align = 'left',
              separator = true,
            },
          },
        },
      }

      -- Keybindings for navigating buffers
      vim.keymap.set('n', '<leader>bn', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
      vim.keymap.set('n', '<leader>bv', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous Buffer' })
      vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Close Buffer' })
    end,
  },

  -- noice for enhanced notifications
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('noice').setup {
        cmdline = {
          enabled = true,
          view = 'cmdline_popup',
          format = {
            cmdline = { icon = '' },
          },
        },
        popupmenu = {
          enabled = true,
        },
        messages = {
          enabled = true,
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
        },
      }
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'EdenEast/nightfox.nvim' },
}
