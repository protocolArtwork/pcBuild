require("luarocks.loader")

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
---@return boolean, string?
local function mkdir(dir, ...)
	local op_report = report_op("mkdir", { dir, ... })
	local success, value = lfs.mkdir(dir)
	if not success then
		local err_report = report_err("mkdir", value, { dir, ... })
		print(err_report)
		return false, value
	else
		print(op_report)
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
	print("There were errors while creating the project skeleton:")

	---@type string[][]
	---@diagnostic disable-next-line
	local eList = value

	for i, v in ipairs(eList) do
		print('\t'..i, unpack(v))
	end
else
	print("Successful created new project directory")
end
