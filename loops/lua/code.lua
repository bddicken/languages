math.randomseed(os.time())
local u = arg[1]
local r = math.random(0, 10000)
local a = {}

for i = 0, 10000 - 1 do
	for j = 0, 100000 - 1 do
		a[i] = (a[i] or 0) + j % u
	end
	a[i] = a[i] + r
end

print(a[r])
