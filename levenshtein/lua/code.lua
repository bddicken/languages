--[[
Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
Time Complexity: O(m*n) where m and n are the lengths of the input strings
--]]
function levenshtein_distance(s1, s2)
    -- Early termination checks
    if s1 == s2 then return 0 end
    if #s1 == 0 then return #s2 end
    if #s2 == 0 then return #s1 end

    -- Make s1 the shorter string for space optimization
    if #s1 > #s2 then
        s1, s2 = s2, s1
    end

    local m, n = #s1, #s2

    -- Use two arrays instead of full matrix for space optimization
    local prev_row = {}
    local curr_row = {}

    -- Initialize first row
    for i = 0, m do
        prev_row[i] = i
    end

    -- Pre-compute string indices for faster access
    local s1_bytes = {string.byte(s1, 1, -1)}
    local s2_bytes = {string.byte(s2, 1, -1)}

    -- Main computation loop
    for j = 1, n do
        curr_row[0] = j

        for i = 1, m do
            local cost = (s1_bytes[i] == s2_bytes[j]) and 0 or 1
            
            -- Calculate minimum of three operations
            curr_row[i] = math.min(
                prev_row[i] + 1,      -- deletion
                curr_row[i-1] + 1,    -- insertion
                prev_row[i-1] + cost  -- substitution
            )
        end

        -- Swap rows
        prev_row, curr_row = curr_row, prev_row
    end

    return prev_row[m]
end

-- Main program
local args = {...}

if #args < 2 then
    print("Please provide at least two strings as arguments.")
    os.exit(1)
end

local min_distance = -1
local times = 0

-- Compare all pairs of strings
for i = 1, #args do
    for j = 1, #args do
        if i ~= j then
            local distance = levenshtein_distance(args[i], args[j])
            if min_distance == -1 or distance < min_distance then
                min_distance = distance
            end
            times = times + 1
        end
    end
end

print(string.format("times: %d", times))
print(string.format("min_distance: %d", min_distance))
