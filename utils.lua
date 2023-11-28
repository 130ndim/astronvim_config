local M = {}

local glob = vim.fn.glob
local system = vim.fn.system
local trim = vim.fn.trim
local path = require("lspconfig.util").path

local function get_python_path(workspace)
  -- 1. Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then return vim.env.VIRTUAL_ENV end

  -- 2. Find and use virtualenv in workspace directory.
  for _, pattern in ipairs { "*", ".*" } do
    local match = glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if not vim.fn.empty(match) then return path.dirname(match) end
  end

  -- 3. Find and use virtualenv managed by Poetry.
  if vim.fn.executable "poetry" and path.is_file(path.join(workspace, "poetry.lock")) then
    local output = trim(system "poetry env info -p")
    if path.is_dir(output) then return output end
  end

  -- 4. Find and use virtualenv managed by Pipenv.
  if vim.fn.executable "pipenv" and path.is_file(path.join(workspace, "Pipfile")) then
    local output = trim(system("cd " .. workspace .. "; pipenv --py"))
    if path.is_dir(output) then return output end
  end

  -- 5. Find and use virtualenv managed by Pyenv.
  if vim.fn.executable "pyenv" and path.is_file(path.join(workspace, ".python-version")) then
    local venv_name = trim(system("cat " .. path.join(workspace, ".python-version")))
    local pyenv_dir = path.join(vim.env.HOME, ".pyenv")
    local virtualenv_dir = path.join(pyenv_dir, "versions", venv_name)

    if path.is_dir(virtualenv_dir) then return virtualenv_dir end
  end
end

function M.get_python_binary_path(workspace)
  local python_dir = get_python_path(workspace)

  if python_dir then return path.join(python_dir, "bin", "python") end
  -- Fallback to system Python.
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

function M.firenvim_not_active() return vim.g["started_by_firenvim"] == nil end

return M
