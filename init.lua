vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.signcolumn = "yes"

vim.pack.add({
	-- Collection of a lot of stuff
	{ src = "https://github.com/echasnovski/mini.nvim" },
	-- LSP completion
	{ src = "https://github.com/Saghen/blink.cmp" },
	-- Install LSP
	{ src = "https://github.com/mason-org/mason.nvim" },
	-- File Explorer
	{ src = "https://github.com/stevearc/oil.nvim" },
	-- Theme
	{ src = "https://github.com/folke/tokyonight.nvim" },
	-- gitsigns
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	-- Format plugin
	{ src = "https://github.com/stevearc/conform.nvim" },
	--syntax highlighting
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require "mini.pick".setup()
vim.keymap.set('n', '<leader>pf', ":Pick files<CR>")
vim.keymap.set('n', '<leader>ph', ":Pick help<CR>")
vim.keymap.set('n', '<leader>pd', ":Pick diagnostic<CR>")
require "mini.pairs".setup()
require "mini.notify".setup()
vim.notify = require('mini.notify').make_notify()
require "mini.icons".setup()
require "mini.extra".setup()
require "mini.indentscope".setup()
require "mini.basics".setup()

require('oil').setup({
	columns = {
		"icon",
		"size"
	},
	watch_for_changes = true,
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set('n', '<leader>e', ":Oil<CR>")

require "blink.cmp".setup({
	fuzzy = { implementation = 'lua' }
})


require 'nvim-treesitter.configs'.setup({
	auto_install = true,
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = false
	},
	indent = {
		enable = false,
	}
})

require "mason".setup()
require 'plugins.python_venv'.setup()
vim.lsp.enable({ "lua_ls", "rust_analyzer", "vtsls", "vue_ls", "terraformls", "tflint", "pyright", "ruff" })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
require('conform').setup({
	formatters_by_ft = {
		lua = { "stylua", lsp_format = "fallback" },
		rust = { "rustfmt", lsp_format = "fallback" },
		python = {
			"ruff_fix",
			"ruff_format",
			"ruff_organize_imports",
		},
	},
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

require('gitsigns').setup()

require('tokyonight').setup()
vim.cmd("colorscheme tokyonight")

vim.cmd(":hi statusline guibg=NONE")
