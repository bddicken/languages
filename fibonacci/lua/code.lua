local function fibonacci(n)
	if n == 0 then
		return 0
	end
	if n == 1 then
		return 1
	end

	return fibonacci(n - 1) + fibonacci(n - 2)
end

local u = tonumber(arg[1])
local r = 0
for i = 0, u - 1 do
	r = r + fibonacci(i)
end
print(r)
