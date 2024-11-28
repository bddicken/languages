local u = tonumber(arg[1])
local r = math.random(10000)

local a = {}
for i = 1, 10000 do
	a[i] = 0
end

for i = 1, 10000 do
	for j = 1, 100000 do
		a[i] = a[i] + j % u
	end
	a[i] = a[i] + r
end

print(a[r])
