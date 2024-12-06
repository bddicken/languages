local ffi = require "ffi"
local i32 = ffi.typeof "int32_t"
math.randomseed(os.time())
local u = i32(tonumber(arg[1]))
local r = i32(math.random(0, 10000))
local a = ffi.new("int32_t[?]", 10000)

local i, j = i32(), i32()
while i < 10000 do
	while j < 100000 do
		a[i] = (a[i] or 0) + j % u
		j = j + 1
	end
	a[i] = a[i] + r
	i = i + 1
end

print(a[r])
