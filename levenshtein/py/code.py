def levenshtein_distance(str1: str, str2: str) -> int:
    if (len(str2) < len(str1)):
        return levenshtein_distance(str2, str1)
    m, n = len(str1), len(str2)
    
    prev = [0] * (m+1)
    curr = [0] * (m+1)
    
    for i in range(m + 1):
        prev[i] = i
    
    # Compute Levenshtein distance
    for i in range(1, n + 1):
        curr[0] = i
        for j in range(1, m + 1):
            # Cost is 0 if characters match, 1 if they differ
            cost = 0 if str1[j-1] == str2[i-1] else 1
            curr[j] = min(
                prev[j] + 1,      # Deletion
                curr[j-1] + 1,      # Insertion
                prev[j-1] + cost  # Substitution
            )
        for j in range(m+1):
            prev[j] = curr[j]
    
    return prev[m]

def main():
    import sys
    
    # Skip the first argument (script name)
    args = sys.argv[1:]
    
    min_distance = -1
    times = 0
    
    # Compare each pair of arguments exactly once
    for i in range(len(args)):
        for j in range(len(args)):
            if i != j:
                distance = levenshtein_distance(args[i], args[j])
                if min_distance == -1 or distance < min_distance:
                    min_distance = distance
                times += 1
    
    # The only output from the program should be the times (number of comparisons) 
    # and min distance calculated of all comparisons. Two total lines of output, 
    # formatted exactly like this.
    print(f"times: {times}")
    print(f"min_distance: {min_distance}")

if __name__ == "__main__":
    main()
