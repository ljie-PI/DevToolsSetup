local function path_type_matches(paths, target_type)
  for _, path in ipairs(paths) do
    local stat = vim.loop.fs_stat(path)
    if stat == nil then
      return false
    end
    if stat.type ~= target_type then
      return false
    end
  end
  return true
end

local M = {}

function M.is_win()
  return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

function M.is_opening_files()
  if vim.fn.argc() == 0 then
    return false
  end
  return path_type_matches(vim.fn.argv(), "file")
end

function M.is_opening_dirs()
  if vim.fn.argc() == 0 then
    return false
  end
  local stat = vim.loop.fs_stat(vim.fn.argv()[1])
  return path_type_matches(vim.fn.argv(), "directory")
end

return M
