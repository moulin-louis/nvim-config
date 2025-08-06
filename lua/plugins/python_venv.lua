-- env-loader.nvim - Simple .env file loader for Neovim
-- Author: Louis MOULIN 
-- License: MIT
-- Based off: https://github.com/benomahony/uv.nvim

-- uv.nvim - Neovim plugin for uv Python package management integration
-- Author: Ben O'Mahony
-- License: MIT

local M = {}

-- Virtual environment activation
function M.activate_venv(venv_path)
	-- For Mac, run the source command to apply to the current shell
	-- Set environment variables for the current Neovim instance
	vim.env.VIRTUAL_ENV = venv_path
	vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
	-- Notify user
	if M.config.notify_activate_venv then
		vim.notify("Activated virtual environment: " .. venv_path, vim.log.levels.INFO)
	end
end

-- Auto-activate the .venv if it exists at the project root
function M.auto_activate_venv()
	local venv_path = vim.fn.getcwd() .. "/.venv"
	if vim.fn.isdirectory(venv_path) == 1 then
		M.activate_venv(venv_path)
		return true
	end
	return false
end


-- Set up auto commands
function M.setup_autocommands()
			M.auto_activate_venv()

			-- Also set up auto-command to check when entering a directory
			vim.api.nvim_create_autocmd({ "DirChanged" }, {
				pattern = { "global" },
				callback = function()
					M.auto_activate_venv()
				end,
			})
end

-- Main setup function
function M.setup(opts)
	M.setup_autocommands()
end

return M
