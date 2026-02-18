vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.winborder = 'rounded'
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = 'unnamedplus'

-- Enable auto reloading when content change
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  command = 'checktime',
})

vim.pack.add {
  -- Collection of a lot of stuff
  { src = 'https://github.com/echasnovski/mini.nvim' },
  -- LSP completion
  { src = 'https://github.com/Saghen/blink.cmp' },
  -- Install LSP
  { src = 'https://github.com/mason-org/mason.nvim' },
  -- File Explorer
  { src = 'https://github.com/stevearc/oil.nvim' },
  -- Theme
  { src = 'https://github.com/folke/tokyonight.nvim' },
  -- gitsigns
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  -- Format plugin
  { src = 'https://github.com/stevearc/conform.nvim' },
  -- fuzzy finder
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  -- Syntax highlighting
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },

  { src = 'https://github.com/folke/todo-comments.nvim' },

  -- Markdown preview
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },

  -- Crates Version
  { src = 'https://github.com/saecki/crates.nvim' },

  -- test
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  -- { src = 'https://github.com/manzanit0/k8s-whisper.nvim' },
}

require('todo-comments').setup()

require('mini.pairs').setup()
require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()
require('mini.icons').setup()
require('mini.extra').setup()
require('mini.indentscope').setup()
require('mini.basics').setup()
require('mini.statusline').setup()

require('telescope').setup {}
local tel_builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sf', tel_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', tel_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', tel_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sd', tel_builtin.diagnostics, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sr', tel_builtin.resume, { desc = 'Telescope resume search' })

require('oil').setup {
  columns = {
    'icon',
    'size',
  },
  watch_for_changes = true,
  view_options = {
    show_hidden = true,
  },
}
vim.keymap.set('n', '<leader>e', ':Oil<CR>')

require('blink.cmp').setup {
  fuzzy = { implementation = 'lua' },
}

require('mason').setup {
  pip = {
    use_uv = true,
  },
}
vim.lsp.enable {
  'lua_ls',
  'rust_analyzer',
  --INFO: JS/TSVue TS
  'vtsls',
  'ts_ls',
  'vue_ls',
  'jsonls',
  --INFO: Terraform/Terragrunt
  'terraformls',
  'tflint',
  --INFO: Python
  'ruff',
  'ty',
  'nil_ls',
  'yamlls',
  --INFO: Go
  'gopls',
  'golangci_lint_ls',
  --INFO: JS/TS linting
}
vim.lsp.inlay_hint.enable(true)

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Diagnostics to quickfix' })
vim.keymap.set('n', '<leader>cF', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
  print('Copied: ' .. vim.fn.expand '%:p')
end, { desc = 'Copy absolute file path' })

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua', lsp_format = 'fallback' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
    python = {
      'ruff_fix',
      'ruff_format',
      'ruff_organize_imports',
    },
    go = { 'goimports', 'gofmt' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    vue = { 'prettier' },
    css = { 'prettier' },
    html = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
}

-- require('k8s-whisper').setup {
--   -- This is a GitHub repository
--   schemas_catalog = 'datreeio/CRDs-catalog',
--   -- This is a git ref, branch, tag, sha, etc.
--   schema_catalog_ref = 'main',
-- }

require('gitsigns').setup {}

require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath 'data' .. '/site',
}
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'rust', 'go', 'lua', 'javascript', 'typescript', 'vue', 'json', 'yaml', 'toml', 'markdown' },
  callback = function()
    vim.treesitter.start()
  end,
})

require('render-markdown').setup {}

require('crates').setup {}

require('tokyonight').setup {}
vim.cmd 'colorscheme tokyonight-night'
