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
  -- { 'akinsho/toggleterm.nvim', version = '*', config = true },
  -- or
  --{'akinsho/toggleterm.nvim', version = "*", opts = {--[[ things you want to change go here]]}}
  -- harpoon
  -- terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      -- Keybindings
      open_mapping = '<leader>t', -- Map leader key + 't' to open a terminal
      size = 20, -- Default terminal size
      hide_numbers = true, -- Hide terminal line numbers
      shade_terminals = true, -- Shade the terminal background
      start_in_insert = true, -- Start the terminal in insert mode
      insert_mappings = true, -- Enable insert mode mappings
      persist_mode = true, -- Persist the terminal mode
      shell = vim.o.shell, -- Use the default shell

      -- Default terminal direction
      direction = 'float', -- Default direction can be 'horizontal', 'vertical', 'float', or 'tab'
    },
  },
  {
    'nvim-lua/plenary.nvim',
  },
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
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
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
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
}
