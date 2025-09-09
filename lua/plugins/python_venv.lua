-- env-loader.nvim - Simple .env file loader for Neovim
-- Author: Louis MOULIN
-- License: MIT
-- Based off: https://github.com/benomahony/uv.nvim

local M = {}

local function activate_venv()
	local venv_path = vim.fn.getcwd() .. "/.venv"
	if vim.fn.isdirectory(venv_path) == 1 then
		vim.env.VIRTUAL_ENV = venv_path
		vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
		vim.notify("Activated virtual environment: " .. venv_path)
	end
end

function M.setup()
	activate_venv()
	vim.api.nvim_create_autocmd("DirChanged", {
		pattern = "global",
		callback = activate_venv,
	})
end

return M
