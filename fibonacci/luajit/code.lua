local ffi = require "ffi"
local i32 = ffi.typeof "int32_t"
local function fibbonacci(n)
	if n == 0 then
		return i32(0)
	end
	if n == 1 then
		return i32(1)
	end
	return fibbonacci(n - 1) + fibbonacci(n - 2)
end

local u = i32(tonumber(arg[1]))
local r = i32(0)
local i = i32(0)
while i < u do
	r = r + fibbonacci(i)
	i = i + 1
end
print(tonumber(r))
