vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"

vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" }
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "mini.pairs".setup()
require "mini.completion".setup()
require "mini.notify".setup()
require "mini.icons".setup()
require "mini.extra".setup()
require "mini.indentscope".setup()
require "mini.basics".setup()

require('oil').setup()

require "blink.cmp".setup({
	fuzzy = { implementation = 'lua' }
})

require "nvim-treesitter.configs".setup({
	highlight = { enable = true },
	auto_install = true,
})

require "mason".setup()

vim.keymap.set('n', '<leader>pf', ":Pick files<CR>")
vim.keymap.set('n', '<leader>ph', ":Pick help<CR>")
vim.keymap.set('n', '<leader>pd', ":Pick diagnostic<CR>")
vim.keymap.set('n', '<leader>o', ":Oil <CR>")


vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

vim.lsp.enable({ "lua_ls", "rust_analyzer", "vtsls", "vue_ls" })

vim.cmd(":hi statusline guibg=NONE")
