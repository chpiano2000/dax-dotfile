local M = {}

function M.setup()
	local dap = require("dap")
	local venv_python_path = function()
		local venv = os.getenv("VIRTUAL_ENV")
		if venv then
			return venv .. "/bin/python"
		end

		local handle = io.popen("which python3 || which python")
		if handle then
			local result = handle:read("*a"):gsub("%s+", "")
			handle:close()
			return result
		end

		return "python"
	end

	require("dap-python").setup()
	require("dap-python").resolve_python = function()
		return venv_python_path()
	end

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = venv_python_path(),
		},
		{
			type = "debugpy",
			request = "launch",
			name = "Django",
			program = "${workspaceFolder}/manage.py",
			args = { "runserver" },
			justMyCode = true,
			django = true,
			console = "integratedTerminal",
			pythonPath = venv_python_path(),
		},
		{
			type = "python",
			request = "attach",
			name = "Attach remote",
			connect = function()
				return {
					host = "localhost",
					port = 5678,
				}
			end,
		},
		{
			type = "python",
			request = "launch",
			name = "Launch file with arguments",
			program = "${file}",
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " +")
			end,
			console = "integratedTerminal",
			pythonPath = venv_python_path(),
		},
	}

	dap.adapters.python = {
		type = "executable",
		command = venv_python_path(),
		args = { "-m", "debugpy.adapter" },
	}
end

return M
