local ColorsMeta = {}

---@param text string
---@param col number
---@return string
function ColorsMeta.xterm_256(text, col)
	local str = string.format("\27[38;5;%dm%s\27[0m", col, text)
	return str
end

return ColorsMeta
