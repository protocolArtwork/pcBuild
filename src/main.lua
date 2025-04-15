require("luarocks.loader")

local lfs = require("lfs")
local pclog = require "log"

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

---@param dir string
---@return boolean, string?
local function mkdir(dir, ...)
	local op_report = report_op("mkdir", { dir, ... })
	local success, value = lfs.mkdir(dir)
	if not success then
		pclog.error(value .. ' (' .. dir .. ')')
		return false, value
	else
		pclog.info(op_report)
		return true, nil
	end
end

---@param dir string
---@return boolean, string[][]?
local function proj_skel(dir)
	local buildDirPath = dir .. "/build"
	local sourceDirPath = dir .. "/src"

	local errors = {}

	if not file_exists(dir) then
		local s, e = mkdir(dir)
		if not s then
			table.insert(errors, { "Could not create base project directory", e })
		end
	end

	if not file_exists(buildDirPath) then
		local s, e = mkdir(buildDirPath, "(Build directory)")
		if not s then
			table.insert(errors, { "Could not create build directory", e })
		end
	end

	if not file_exists(sourceDirPath) then
		local s, e = mkdir(sourceDirPath, "(Source directory)")
		if not s then
			table.insert(errors, { "Could not create source directory", e })
		end
	end

	local s = #errors == 0
	return s, (not s) and errors or nil
end

local createSuccess, value = proj_skel(arg[1])

-- PROCESS RESULTS
print()

if not createSuccess then
	pclog.warn("There were errors while creating the project skeleton:")

	---@type string[][]
	---@diagnostic disable-next-line
	local eList = value

	for i, v in ipairs(eList) do
		print('\t'..i, unpack(v))
	end
else
	print("Successful created new project directory")
end
