vim.opt.winborder = 'rounded'
vim.opt.tabstop = 2
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
	-- Syntax hightligtin
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },

	{ src = 'https://github.com/folke/todo-comments.nvim' },
	{ src = 'https://github.com/folke/tokyonight.nvim' },

	-- Markdown preview
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }
}

require('todo-comments').setup()

require('mini.pairs').setup()
require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()
require('mini.icons').setup()
require('mini.extra').setup()
require('mini.indentscope').setup()
require('mini.basics').setup()

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
require('mason').setup()
vim.lsp.enable { 'lua_ls', 'rust_analyzer', 'vtsls', 'vue_ls', 'terraformls', 'tflint', 'basedpyright', 'ruff' }

vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
require('conform').setup {
	formatters_by_ft = {
		lua = { 'stylua', lsp_format = 'fallback' },
		rust = { 'rustfmt', lsp_format = 'fallback' },
		python = {
			'ruff_fix',
			'ruff_format',
			'ruff_organize_imports',
		},
	},
}
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	callback = function(args)
		require('conform').format { bufnr = args.buf }
	end,
})

require('gitsigns').setup {}

require('nvim-treesitter').setup {
	auto_install = true,
	highlight = {
		enable = true,
	},
}

require('render-markdown').setup {}

require('tokyonight').setup {}

vim.cmd 'colorscheme tokyonight-night'
