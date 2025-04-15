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
---@return string
local function report_op(op, args)
	local argStr = table.concat(args, SEP_OP_ARGS)
	local reportStr = string.format(FMT_OP, op, argStr)
	return reportStr
end

local FMT_ERR = "[ERROR (%s)]\n\tInfo:\t%s\n\tError:\t%s"

---@param op_args string[]
---@param op string
---@param err string
local function report_err(op, err, op_args)
	local argStr = table.concat(op_args, SEP_OP_ARGS)
	local reportStr = string.format(FMT_ERR, op, argStr, err)
	return reportStr
end

---@param dir string
local function mkdir(dir,...)
	local op_report = report_op("mkdir", {dir,...})
	local success, value = lfs.mkdir(dir)
	if not success then
		local err_report = report_err("mkdir", value, {dir, ...})
		print(err_report)
	else
		print(op_report)
	end
end

---@param dir string 
local function proj_skel(dir)
	local buildDirPath = dir .. "/build"
	local sourceDirPath = dir .. "/src"

	if not file_exists(dir) then
		mkdir(dir)
	end

	if not file_exists(buildDirPath) then
		mkdir(buildDirPath, "(Build directory)")
	end

	if not file_exists(sourceDirPath) then
		mkdir(sourceDirPath, "(Source directory)")
	end
end

proj_skel(arg[1])
