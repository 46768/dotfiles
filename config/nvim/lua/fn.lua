local OSName = vim.loop.os_uname().sysname
function fixPath(path)
	path = path:gsub("\\", "/")
	return path
end

local module = {
	OS = OSName,
	DATA = vim.fn.stdpath('data'),

	normalizePath = fixPath,
	fixMasonBin = function(path)
		if OSName == "Windows_NT" then
			path = path .. ".cmd"
		end
		return path
	end,
	findMasonPackageFile = function(packName, rg)
		local wd = fixPath(vim.fn.stdpath('data') .. '/mason/packages/' .. packName)
		local obj = vim.system({'find', wd, '-type', 'f', '-name', rg}, { cwd = wd }):wait()
		return obj.stdout:gsub('\n', '')
	end,
	findMasonPackageDir = function(packName, rg)
		local wd = fixPath(vim.fn.stdpath('data') .. '/mason/packages/' .. packName)
		local obj = vim.system({'find', wd, '-type', 'd', '-name', rg}, { cwd = wd }):wait()
		return obj.stdout:gsub('\n', '')
	end,
	listMasonPackageDir = function(packName)
		local wd = fixPath(vim.fn.stdpath('data') .. '/mason/packages/' .. packName)
		local obj = vim.system({'ls'}, { cwd = wd }):wait()
		return obj.stdout
	end,
}

return module
