local function processInput()
    -- Use table.unpack for more reliable argument handling
    local args = { table.unpack(arg or {}) }
    local input = args[1] or ""

    -- Early return for invalid input with error checking
    if input == "" then
        io.stderr:write("Invalid input (Blank Input)\n")
        os.exit(1)
    end

    -- Optimize number conversion with pcall for error handling
    local success, number = pcall(tonumber, input)
    if not success or number == nil then
        io.stderr:write("Error: Input cannot be converted to a number\n")
        os.exit(1)
    end

    -- Seed random number generator for consistent results
    math.randomseed(os.time())

    -- Optimize random selection
    local r = math.random(number)

    -- Preallocate array with more efficient method
    local a = table.create and table.create(10000, 0) or {}
    for i = 1, 10000 do a[i] = 0 end

    -- Optimize nested loops with local variables and reduced computations
    local result = 0
    for i = 1, 10000 do
        local sum = 0
        for j = 1, 10000 do
            sum = sum + (j % number)
        end
        result = sum + r
    end

    -- Print final result
    print(result)
end

-- Protected call to handle potential errors
local status, err = pcall(processInput)
if not status then
    io.stderr:write("Unexpected error: " .. tostring(err) .. "\n")
    os.exit(1)
end
