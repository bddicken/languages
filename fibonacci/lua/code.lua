local function fibbonacci(n)
	if n == 0 then
		return 0
	end
	if n == 1 then
		return 1
	end
	return fibbonacci(n - 1) + fibbonacci(n - 2)
end

local u = arg[1]
local r = 0
for i = 1, u - 1 do
	r = r + fibbonacci(i)
end
print(r)
