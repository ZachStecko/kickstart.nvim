--[[
  Plugin checklist
  - icons
  - file explorer
  - terminal
  - harpoon
  - lazy git
  ]]

-- Keybindings for ToggleTerm
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical size=50<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tb', '<cmd>ToggleTerm direction=horizontal size=20<CR>', { noremap = true, silent = true })

-- Enter insert mode when opening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  command = 'startinsert',
})

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
    opts = {
      open_mapping = '<leader>t',
      size = 20,
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      persist_mode = true,
      shell = vim.o.shell,
      direction = 'float',
    },
  },

  -- plenary for utility functions
  {
    'nvim-lua/plenary.nvim',
  },

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
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
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
  -- Bufferline for file tabs
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
          -- Add an offset for NvimTree
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
              text_align = 'left', -- Aligns the label to the left
              separator = true, -- Adds a separator between NvimTree and bufferline
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
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim', -- UI Component Library
      'rcarriga/nvim-notify', -- Optional: Notification component
      'nvim-treesitter/nvim-treesitter', -- Optional: For better syntax highlighting in messages
    },
    config = function()
      require('noice').setup {
        cmdline = {
          enabled = true, -- Enable the command line UI replacement
          view = 'cmdline_popup', -- Use a popup for the command line
          format = {
            cmdline = { icon = '' }, -- Icon before the command line
          },
        },
        popupmenu = {
          enabled = true, -- Enable popup menu for command completions
        },
        messages = {
          enabled = true, -- Enable message UI replacement
        },
        presets = {
          bottom_search = false, -- Disable bottom search prompt
          command_palette = true, -- Center the command line
          long_message_to_split = true,
        },
      }
    end,
  },
}
