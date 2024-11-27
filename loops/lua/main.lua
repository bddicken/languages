arg = { ... } -- Capture command-line arguments
Input = arg[1] or ""
if Input == "" then
    print("Invalid input (Blank Input)")
else
    local number = tonumber(Input)
    if number == nil then
        print("Error: Input cannot be converted to a number")
    else
        -- Successful number conversion
        local r = (math.random(number))
        local a = {} -- new array
        for i = 1, 10000 do
            a[i] = 0
        end
        for i = 1, 10000 do
            for j = 1, 10000 do
                a[i] = a[i] + j % number
            end
            a[i] = a[i] + r
        end
        print(a[r])
    end
end
