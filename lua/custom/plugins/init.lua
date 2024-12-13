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
--Lua:

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
}
