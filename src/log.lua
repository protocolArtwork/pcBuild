---@class Log
---@field info fun(text: string)
---@field warn fun(text: string)
---@field err fun(text: string)
local Log = { __index = {} }

---@enum LogTypeId
local LOG_TYPE_ID = {
	info = 1,
	warn = 2,
	error = 3,
}

Log.LogType = LOG_TYPE_ID

---@param text string
local function output(text)
	io.write(text)
end

---@type string
local FMT_WARN = "[WARN]\t%s\n"
local FMT_INFO = "[INFO]\t%s\n"
local FMT_ERROR = "[ERROR]\t%s\n"

---@param text string
function Log.info(text)
	output(string.format(FMT_INFO, text))
end

---@param text string
function Log.warn(text)
	output(string.format(FMT_WARN, text))
end

---@param text string
function Log.error(text)
	output(string.format(FMT_ERROR, text))
end

local LOG_LEVEL_FNS = {
	[LOG_TYPE_ID.info] = Log.info,
	[LOG_TYPE_ID.warn] = Log.warn,
	[LOG_TYPE_ID.error] = Log.error,
}

---@param level LogTypeId
function Log.log(level, ...)
	assert(LOG_LEVEL_FNS[level], "Invalid log level: " .. level)
	LOG_LEVEL_FNS[level](...)
end

return Log
