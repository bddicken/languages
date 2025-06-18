module Levenshtein

export levenshtein_distance, distances

# Calculates the Levenshtein distance between two strings using the Wagner-Fischer algorithm.
# Space Complexity: O(min(m,n)) – allocates two arrays per call.
# Time Complexity: O(m*n) where m and n are the lengths of the input strings.
function levenshtein_distance(str1::String, str2::String)::Int
    # Early termination checks
    if str1 == str2
        return 0
    end
    s1 = codeunits(str1)
    s2 = codeunits(str2)
    if isempty(s1)
        return length(s2)
    elseif isempty(s2)
        return length(s1)
    end

    # Make s1 the shorter string for space optimization
    if length(s1) > length(s2)
        s1, s2 = s2, s1
    end

    m, n = length(s1), length(s2)

    prev_row = Vector{Int32}(undef, m + 1)
    curr_row = Vector{Int32}(undef, m + 1)

    # Initialize first row
    for i in 0:m
        @inbounds prev_row[i + 1] = Int32(i)
    end

    # Main computation loop
    @inbounds for j in 1:n
        curr_row[1] = Int32(j)
        for i in 1:m
            cost = s1[i] == s2[j] ? 0 : 1
            @inbounds curr_row[i + 1] = min(
                prev_row[i + 1] + 1,    # deletion
                curr_row[i] + 1,        # insertion
                prev_row[i] + cost      # substitution
            )
        end
        # Swap rows (we simply swap the array references)
        prev_row, curr_row = curr_row, prev_row
    end

    return @inbounds prev_row[m + 1]
end

# distances : Vector{String} -> Vector{Int}
#
# Computes the Levenshtein distance for every unique unordered pair of strings.
# That is, for each pair (A, B) with A ≠ B the distance is computed only once.
function distances(strings::Vector{String})
    n = length(strings)
    count = n*(n-1) ÷ 2
    dists = Vector{Int}(undef, count)
    idx = 1
    for i in 1:(n-1)
        for j in (i+1):n
            dists[idx] = levenshtein_distance(strings[i], strings[j])
            idx += 1
        end
    end
    return dists
end

end # module Levenshtein
