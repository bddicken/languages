# Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
# Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
# Time Complexity: O(m*n) where m and n are the lengths of the input strings
function levenshtein_distance(s1, s2,    m, n, prev_row, curr_row, i, j, cost, deletion, insertion, substitution) {
    # Early termination checks
    if (s1 == s2) return 0
    if (length(s1) == 0) return length(s2)
    if (length(s2) == 0) return length(s1)

    # Make s1 the shorter string for space optimization
    if (length(s1) > length(s2)) {
        temp = s1
        s1 = s2
        s2 = temp
    }

    m = length(s1)
    n = length(s2)

    # Initialize first row
    for (i = 0; i <= m; i++) {
        prev_row[i] = i
    }

    # Main computation loop
    for (j = 1; j <= n; j++) {
        curr_row[0] = j

        for (i = 1; i <= m; i++) {
            # Get characters at current position
            # Note: substr in awk is 1-based
            cost = (substr(s1, i, 1) == substr(s2, j, 1)) ? 0 : 1
            
            # Calculate minimum of three operations
            deletion = prev_row[i] + 1
            insertion = curr_row[i-1] + 1
            substitution = prev_row[i-1] + cost
            
            curr_row[i] = deletion
            if (insertion < curr_row[i]) curr_row[i] = insertion
            if (substitution < curr_row[i]) curr_row[i] = substitution
        }

        # Copy current row to previous row
        for (i = 0; i <= m; i++) {
            prev_row[i] = curr_row[i]
        }
    }

    return prev_row[m]
}

# Main program
BEGIN {
    if (ARGC < 3) {
        print "Please provide at least two strings as arguments."
        exit 1
    }

    min_distance = -1
    times = 0

    # Compare all pairs of strings
    # Note: ARGC includes the script name, so we start from 1
    for (i = 1; i < ARGC; i++) {
        for (j = 1; j < ARGC; j++) {
            if (i != j) {
                distance = levenshtein_distance(ARGV[i], ARGV[j])
                if (min_distance == -1 || distance < min_distance) {
                    min_distance = distance
                }
                times++
            }
        }
    }

    printf "times: %d\n", times
    printf "min_distance: %d\n", min_distance
    exit 0
}
