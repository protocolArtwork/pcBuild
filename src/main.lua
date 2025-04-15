require 'luarocks.loader'

local lfs = require("lfs")

local function file_exists(filename)
    local attr = lfs.attributes(filename)
    return attr and attr.mode == "file"
end

local FMT_OP = "[%s] %s"
local SEP_OP_ARGS = ", "

---@param op string
---@param args string[]
local function report_op(op, args)
	local argStr = table.concat(args, SEP_OP_ARGS)
	local reportStr = string.format(FMT_OP, op, argStr)
end

---@param dir string
local function mkdir(dir,...)
	report_op("mkdir", {dir,...})
	return lfs.mkdir(dir)
end

---@param dir string 
local function proj_skel(dir)
	local buildDirPath = dir .. "/build"
	local sourceDirPath = dir .. "/src"

	if not file_exists(dir) then
		mkdir(dir)
	end

	if not file_exists(buildDirPath) then
		print(mkdir(buildDirPath, "(Build directory)"))
	end

	if not file_exists(sourceDirPath) then
		mkdir(sourceDirPath, "(Source directory)")
	end
end

proj_skel(arg[1])
