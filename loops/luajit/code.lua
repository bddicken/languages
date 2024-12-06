local ffi = require "ffi";
math.randomseed(os.time())
local u = ffi.new("int32_t", tonumber(arg[1]))
local r = ffi.new("int32_t", math.random(0, 10000))
local a = ffi.new("int32_t[?]", 10000)

local ione = ffi.new("int32_t",1)
local i = ffi.new("int32_t[1]")
local j = ffi.new("int32_t[1]")
while i[0] < 10000 do
	while j[0] < 100000 do
		a[i[0]] = (a[i[0]] or 0) + j[0] % u
		j[0] = j[0] + ione
	end
	a[i[0]] = a[i[0]] + r
	i[0] = i[0] + ione
end

print(a[r])
